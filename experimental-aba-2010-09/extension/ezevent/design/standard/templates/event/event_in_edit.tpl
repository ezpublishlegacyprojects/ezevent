{def $has_own_drafts=false()
     $has_other_drafts=false()
     $current_creator=fetch(user,current_user)}
{foreach $draft_versions as $item}
    {if eq($item.creator_id,$current_creator.contentobject_id)}
        {set has_own_drafts=true()}
    {else}
        {set has_other_drafts=true()}
    {/if}
{/foreach}
<form method="post" action={concat('content/edit/',$object.id,'/',$edit_language )|ezurl}>

<div class="objectheader">
<h2>{$event.content_object.name|wash}</h2>
</div>

<div class="object">
<p>
{"The currently published version is %version and was published at %time."|i18n('design/standard/content/edit',,hash('%version',$object.current_version,'%time',$object.published|l10n(datetime) ))}
</p>
<p>
{"The last modification was done at %modified."|i18n('design/standard/content/edit',,hash('%modified',$object.modified|l10n(datetime)))}
</p>
<p>
{"The object is owned by %owner."|i18n('design/standard/content/edit',,hash('%owner',$object.owner.name))}
</p>
</div>

{section show=and($has_own_drafts,$has_other_drafts)}
<p>
   {"This object is already being edited by yourself or someone else.
    You can either continue editing one of your drafts or you can create a new draft."|i18n('design/standard/content/edit')}    
</p>
{section-else}
    {section show=$has_own_drafts}
    <p>
      {"This object is already being edited by you.
        You can either continue editing one of your drafts or you can create a new draft."|i18n('design/standard/content/edit')}        
    </p>
    {/section}
    {section show=$has_other_drafts}
    <p>
      {"This object is already being edited by someone else.
        You should either contact the person about the draft or create a new draft for personal editing."|i18n('design/standard/content/edit')}
    </p>
    {/section}
{/section}

<h2>{'Current drafts'|i18n('design/standard/content/edit')}</h2>

<table class="list" width="100%" cellspacing="0" cellpadding="0">
<tr>
    {section show=$has_own_drafts}
        <th>
            &nbsp;
        </th>
    {/section}
    <th>
        {'Version'|i18n('design/standard/content/edit')}
    </th>
    <th>
        {'Name'|i18n('design/standard/content/edit')}
    </th>
    <th>
        {'Owner'|i18n('design/standard/content/edit')}
    </th>
    <th>
        {'Created'|i18n('design/standard/content/edit')}
    </th>
    <th>
        {'Last modified'|i18n('design/standard/content/edit')}
    </th>
</tr>
{section name=Draft loop=$draft_versions sequence=array(bglight,bgdark)}
<tr class="{$:sequence}">
    {section show=$has_own_drafts}
        <td width="1">
            {section show=eq($:item.creator_id,$current_creator.contentobject_id)}
                <input type="radio" name="SelectedVersion" value="{$:item.version}"
                    {run-once}
                        checked="checked"
                    {/run-once}
                 />
            {/section}
        </td>
    {/section}
    <td width="1">
        {$:item.version}
    </td>
    <td>
        <a href={concat('content/versionview/',$object.id,'/',$:item.version)|ezurl}>{$:item.version_name|wash}</a>
    </td>
    <td>
        {content_view_gui view=text_linked content_object=$:item.creator}
    </td>
    <td>
        {$:item.created|l10n(shortdatetime)}
    </td>
    <td>
        {$:item.modified|l10n(shortdatetime)}
    </td>
</tr>
{/section}
</table>

{section show=and($has_own_drafts,$has_other_drafts)}
    <input class="defaultbutton" type="submit" name="EditButton" value="{'Edit'|i18n('design/standard/content/edit')}" />
    <input class="button" type="submit" name="NewDraftButton" value="{'New draft'|i18n('design/standard/content/edit')}" />
{section-else}
    {section show=$has_own_drafts}
        <input class="defaultbutton" type="submit" name="EditButton" value="{'Edit'|i18n('design/standard/content/edit')}" />
        <input class="button" type="submit" name="NewDraftButton" value="{'New draft'|i18n('design/standard/content/edit')}" />
    {/section}
    {section show=$has_other_drafts}
        <input class="defaultbutton" type="submit" name="NewDraftButton" value="{'New draft'|i18n('design/standard/content/edit')}" />
    {/section}
{/section}

</form>

