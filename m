Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04DF9782638
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 11:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbjHUJ1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 05:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjHUJ1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 05:27:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A27FC7;
        Mon, 21 Aug 2023 02:27:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EC0662CE8;
        Mon, 21 Aug 2023 09:27:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE64C433C7;
        Mon, 21 Aug 2023 09:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692610035;
        bh=nzfsOP8ZfW0Kf6CwX63e/wWipgnj7gweYgyYH96xch0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ULjMk6/bXS/xZzZsQwusR382GwzpOA29vvjhwlayyXJT0PTMBYbcnpgIvZaaw1OOY
         9gezSKyH1oGC4DwWZyWm2cfSKIh4UydqBZtVamezZ7MIxKhkusdtM0gRgO0ohHF0Nh
         3W7YnTPilshOVEBELEIue1UFzWkc+UcG04/DwFRJL+36UZVqBnq9FohEdbJnt7mijK
         B8sF8YXm0TYu2rfT/1i8Piw3MKsHtJptrHsCdxfrmIeEr7pJ3KX/7kJsuntczCnOuH
         PqCjlXuYozOGRNezKRVQiYQDhtqUYcAjLCgf8fRJsDVcEgJAHFvKFVGUvqIibWTXlB
         a8OtYWd88wHLw==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A140ED3CB14; Mon, 21 Aug 2023 11:27:11 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] docs: submitting-patches: Add Sponsored-by tag
 to give credits to who sponsored the patch
In-Reply-To: <CAMuHMdVY7vaU8wpJrMD4HNkQwkJD0Rd9sL-xFDYXxJEcP91yuw@mail.gmail.com>
References: <20230817220957.41582-1-giulio.benetti@benettiengineering.com>
 <20230817220957.41582-2-giulio.benetti@benettiengineering.com>
 <20230817232348.GC1175@pendragon.ideasonboard.com>
 <28289906-4fd1-26aa-b1c4-eb393ac52d48@benettiengineering.com>
 <CAMuHMdVY7vaU8wpJrMD4HNkQwkJD0Rd9sL-xFDYXxJEcP91yuw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 21 Aug 2023 11:27:11 +0200
Message-ID: <878ra4bv9s.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Hi Giulio,
>
> On Sun, Aug 20, 2023 at 2:35=E2=80=AFAM Giulio Benetti
> <giulio.benetti@benettiengineering.com> wrote:
>> On 18/08/23 01:23, Laurent Pinchart wrote:
>> > On Fri, Aug 18, 2023 at 12:09:57AM +0200, Giulio Benetti wrote:
>> >> Sometimes it happens that a Company or a Physical Person sponsors the
>> >> creation and/or the upstreaming process of a patch, but at the moment
>> >> there is no way to give credits to it. There are some commit that inc=
lude
>> >> a sort of tag "Sponsored by" without the dash to avoid
>> >> scripts/checkpatch.pl to complain but a real standard has not been de=
fined.
>> >> With this patch let's try to define a method to give credits consiste=
ntly
>> >> including an acknowledge from the sponsor. The goal is to improve
>> >> contributions from companies or physical persons that this way should=
 gain
>> >> visibility in Linux kernel and so they should be more prone to let the
>> >> work done for them for to be upstreamed.
>> >
>> > Just adding one data point here, without judging on the merits of this
>> > proposal. I've been requested previously by customers to increase their
>> > visibility in the kernel development statistics, and the way we found =
to
>> > do so was to sign-off patches with
>> >
>> > Laurent Pinchart <laurent.pinchart+customer@ideasonboard.com>
>> >
>> > (where "customer" is to be replaced with the customer name).
>>
>> this approach works good for the developer because of the +customer
>> mailbox capability but in term of appeal for the final customer I've
>> been told(by the customer) he would really like more the "Sponsored-by:"
>> way. To tell the truth while I was looking for an existing alternative
>> I've found the commits with "Sponsored by:" pseudo-tag that look cooler.
>>
>> This is my taste of course and the taste of one of my customers, but
>> to me it's like having a brand shown:
>> Sponsored-by: Sponsoring Company
>> vs:
>> Signed-off-by: Giulio Benetti
>> <giulio.benetti+sponsor.company@benettiengineering.com>
>
> Personally, I would respond "I'm sorry, but the only advertising
> space we offer are Copyright headers (for employees) and
> "user+customer@..." or "name (customer) user@..." (for contractors).
>
> And this is a separate tag, so it's harder for the analysis tools
> (whose output your customers must be interested in, too?) to
> match the tag to the actual Author/Reviewer/...
>
>> If I am the customer I'd really prefer the first option.
>
> You are aware this will cause lots of work for the customer, too?
> (See below).
>
>> >> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
>> >> ---
>> >>   Documentation/process/submitting-patches.rst | 38 +++++++++++++++++=
+++
>> >>   1 file changed, 38 insertions(+)
>> >>
>> >> diff --git a/Documentation/process/submitting-patches.rst b/Documenta=
tion/process/submitting-patches.rst
>> >> index efac910e2659..870e6b5def3f 100644
>> >> --- a/Documentation/process/submitting-patches.rst
>> >> +++ b/Documentation/process/submitting-patches.rst
>> >> @@ -600,6 +600,44 @@ process nor the requirement to Cc: stable@vger.k=
ernel.org on all stable
>> >>   patch candidates. For more information, please read
>> >>   Documentation/process/stable-kernel-rules.rst.
>> >>
>> >> +Using Sponsored-by:
>> >> +-------------------
>> >> +
>> >> +A Sponsored-by tag gives credit to who sponsored the creation and/or=
 the
>> >> +upstreaming process of the patch. Sponsored-by can contain a company=
 name or
>> >> +a physical person name. If a company sponsored the patch this is the=
 form::
>> >> +
>> >> +    Company Name <mail@companyname.com>
>> >> +
>> >> +where the Company Name must be a valid Business Name at the time of =
sending the
>> >> +patch until the confirmation of the Sponsored-by tag, while the e-ma=
il can be
>> >> +either a generic e-mail the company can be reached out or an e-mail =
of a person
>> >> +who has the rights inside it to confirm the Sponsored-by tag.
>> >> +
>> >> +If a physical person sponsored the patch the form must be same used =
in
>> >> +Signed-off-by tag::
>> >> +
>> >> +    Physical Person <physical.person@mail.com>
>> >> +
>> >> +In both cases, to prevent fake credits, either the company or the pe=
rson should
>> >> +send an Acked-by tag placed right under Sponsored-by tag using the s=
ame form
>> >> +described above. So for example if the patch contains::
>> >> +
>> >> +    <changelog>
>> >> +
>> >> +    Sponsored-by: Company Name <mail@companyname.com>
>> >> +    Signed-off-by: Developer Name <developer.name@developername.com>
>> >> +
>> >> +The result including the answer from the sponsor must be::
>> >> +
>> >> +    <changelog>
>> >> +
>> >> +    Sponsored-by: Company Name <mail@companyname.com>
>> >> +    Acked-by: Company Name <mail@companyname.com>
>> >> +    Signed-off-by: Developer Name <developer.name@developername.com>
>> >> +
>> >> +This way the sponsor agrees to the usage of this tag using its name.
>
> This is also causing more work for maintainers: now they have to check
> if any Sponsored-by tags are present, and track if there is a response
> with a matching Acked-by tag...
>
> And obviously they should postpone applying the patch until a
> confirmation response is sent... which may never happen...

Yeah, definitely not going to track that. I'm pretty agnostic to the tag
itself, but please don't put the burden of validity testing of it on
maintainers...

-Toke
