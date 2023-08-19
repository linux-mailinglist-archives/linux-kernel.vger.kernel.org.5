Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C38781B88
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 02:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjHTALI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 20:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjHTAKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 20:10:50 -0400
Received: from smtpcmd0653.aruba.it (smtpcmd0653.aruba.it [62.149.156.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060F74D545B
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 13:39:17 -0700 (PDT)
Received: from [192.168.1.205] ([95.47.160.93])
        by Aruba Outgoing Smtp  with ESMTPSA
        id XSj3qPZ8MvaOzXSj3qL3nc; Sat, 19 Aug 2023 22:39:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1692477555; bh=Y+617Sg7iVcCJf4zQhmRmtSAkAFO3G4P4WnvSIywqQE=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=nl912ixlvF/1gkbSF9rhRN16kcotz5vEuYW3dHvFXxRcixbrYZyjjW3yTGndbITof
         La26ofNGL469NrO2+gZFqQDHCEMUMJhUmKLSLDUbuXD00bLOJ+CtEbbhai8GKHsA5U
         PiZSM25bsRNaIkaEfr/dOwcrrZcGyKYcBgi3otYPeIN+iVQ5OkgaPJAJzuOCufhdDW
         nfjjgayQye9i/AjBTlpuNqZifwDKEKECCm0ECkEAmFu2DOtxjrS7ODE3JEc4FAHki6
         JYxxMuMDiAT7KrGCQ7uaTsC+rUXMj9xm3IGqqMNaCqP1pwzh55QGi3UIN/xRzbjtoG
         y5KPsn1NHkOOg==
Message-ID: <28289906-4fd1-26aa-b1c4-eb393ac52d48@benettiengineering.com>
Date:   Sat, 19 Aug 2023 22:39:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH 1/1] docs: submitting-patches: Add Sponsored-by tag to
 give credits to who sponsored the patch
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230817220957.41582-1-giulio.benetti@benettiengineering.com>
 <20230817220957.41582-2-giulio.benetti@benettiengineering.com>
 <20230817232348.GC1175@pendragon.ideasonboard.com>
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
In-Reply-To: <20230817232348.GC1175@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfBTz2ZCrLNJ3ob3IUlU9ehPG9JEU1kDz3UjvhDTpUQojPcEWTwJ5ZnEZEQ5oKlytRDZnLBC1CjDOtMJTaMdRr61AO7wFcJvPP1OJEbtdS+tZUMoFoa1l
 BBtbScJcap8+adCGqjuW8utsTlKWKvMFDo/uC8UWsZeX/ABL9ygRGSbKqMZFW0KlXt6m71s3YvYNDwHyPaFfxZMvF+uMnIfXVMikH6/S4Ehs8C3L4c+absqb
 nonnAmdutq8At1o0Ev9zZKoE4anaq9tbT5MJUuX9mpKYcCX7vnbRpXHhwSms6q44aLkASzoWjPDZovXN7iebydIuE4BXziRfsZMGC7fvZ4ejOnoCXCf4/4FJ
 gdHPrcrTUUk+JlLcGWRKSQ9RyDJTeQ==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 18/08/23 01:23, Laurent Pinchart wrote:
> Hi Giulio,
> 
> On Fri, Aug 18, 2023 at 12:09:57AM +0200, Giulio Benetti wrote:
>> Sometimes it happens that a Company or a Physical Person sponsors the
>> creation and/or the upstreaming process of a patch, but at the moment
>> there is no way to give credits to it. There are some commit that include
>> a sort of tag "Sponsored by" without the dash to avoid
>> scripts/checkpatch.pl to complain but a real standard has not been defined.
>> With this patch let's try to define a method to give credits consistently
>> including an acknowledge from the sponsor. The goal is to improve
>> contributions from companies or physical persons that this way should gain
>> visibility in Linux kernel and so they should be more prone to let the
>> work done for them for to be upstreamed.
> 
> Just adding one data point here, without judging on the merits of this
> proposal. I've been requested previously by customers to increase their
> visibility in the kernel development statistics, and the way we found to
> do so was to sign-off patches with
> 
> Laurent Pinchart <laurent.pinchart+customer@ideasonboard.com>
> 
> (where "customer" is to be replaced with the customer name).

this approach works good for the developer because of the +customer
mailbox capability but in term of appeal for the final customer I've
been told(by the customer) he would really like more the "Sponsored-by:"
way. To tell the truth while I was looking for an existing alternative
I've found the commits with "Sponsored by:" pseudo-tag that look cooler.

This is my taste of course and the taste of one of my customers, but
to me it's like having a brand shown:
Sponsored-by: Sponsoring Company
vs:
Signed-off-by: Giulio Benetti 
<giulio.benetti+sponsor.company@benettiengineering.com>

If I am the customer I'd really prefer the first option.

Kind regards
-- 
Giulio Benetti
CEO&CTO@Benetti Engineering sas

>> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
>> ---
>>   Documentation/process/submitting-patches.rst | 38 ++++++++++++++++++++
>>   1 file changed, 38 insertions(+)
>>
>> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
>> index efac910e2659..870e6b5def3f 100644
>> --- a/Documentation/process/submitting-patches.rst
>> +++ b/Documentation/process/submitting-patches.rst
>> @@ -600,6 +600,44 @@ process nor the requirement to Cc: stable@vger.kernel.org on all stable
>>   patch candidates. For more information, please read
>>   Documentation/process/stable-kernel-rules.rst.
>>   
>> +Using Sponsored-by:
>> +-------------------
>> +
>> +A Sponsored-by tag gives credit to who sponsored the creation and/or the
>> +upstreaming process of the patch. Sponsored-by can contain a company name or
>> +a physical person name. If a company sponsored the patch this is the form::
>> +
>> +	Company Name <mail@companyname.com>
>> +
>> +where the Company Name must be a valid Business Name at the time of sending the
>> +patch until the confirmation of the Sponsored-by tag, while the e-mail can be
>> +either a generic e-mail the company can be reached out or an e-mail of a person
>> +who has the rights inside it to confirm the Sponsored-by tag.
>> +
>> +If a physical person sponsored the patch the form must be same used in
>> +Signed-off-by tag::
>> +
>> +	Physical Person <physical.person@mail.com>
>> +
>> +In both cases, to prevent fake credits, either the company or the person should
>> +send an Acked-by tag placed right under Sponsored-by tag using the same form
>> +described above. So for example if the patch contains::
>> +
>> +	<changelog>
>> +
>> +	Sponsored-by: Company Name <mail@companyname.com>
>> +	Signed-off-by: Developer Name <developer.name@developername.com>
>> +
>> +The result including the answer from the sponsor must be::
>> +
>> +	<changelog>
>> +
>> +	Sponsored-by: Company Name <mail@companyname.com>
>> +	Acked-by: Company Name <mail@companyname.com>
>> +	Signed-off-by: Developer Name <developer.name@developername.com>
>> +
>> +This way the sponsor agrees to the usage of this tag using its name.
>> +
>>   .. _the_canonical_patch_format:
>>   
>>   The canonical patch format
> 

