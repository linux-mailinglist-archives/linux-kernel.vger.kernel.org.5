Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D177863EE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 01:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238685AbjHWXZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 19:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238587AbjHWXYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 19:24:48 -0400
Received: from smtpcmd12132.aruba.it (smtpcmd12132.aruba.it [62.149.156.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0212A10C7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 16:24:45 -0700 (PDT)
Received: from [192.168.50.162] ([146.241.122.243])
        by Aruba Outgoing Smtp  with ESMTPSA
        id YxDPqkwXbgpIyYxDQqIruj; Thu, 24 Aug 2023 01:24:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1692833084; bh=VGdc6KXHLwTDyNU/iWvnFgIPAKZekqrLkzsEwIqRAYo=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=NTIua1scOcEe6ugGElh3WAN19Q34A6IE/Iipks/SrcV7Lgy5Ms25fPEVUfOPpklf0
         lHKrdcOb/oBuDxssnMA9Ao3ijkvYtcnzeFxHjVOCQz0Z7U3hYWGkE+7B1e9Ji410lT
         sZroIfzmY43fVGJB9/hiTLlF4EUj0DMoBaWdSh0UNeIjyLnCG/muT5pdNvmsZT9DS/
         NJ35lPJ27If5CcQELuZRi1wBdd3KoE04dlUtgx3/UjqnnmW7KmvYZpv9DX+Ie81pCL
         O9JrT4QcFvWEB/TmYlEFX8UT405G3oCkpmVPYmLLPaxfiYmfxnPM4ZQ/mTrtnuJSPX
         VfcN7vTkN+VFg==
Message-ID: <0a2c9daf-c301-8683-9af5-c64ce5d516ca@benettiengineering.com>
Date:   Thu, 24 Aug 2023 01:24:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH 1/1] docs: submitting-patches: Add Sponsored-by tag to
 give credits to who sponsored the patch
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230817220957.41582-1-giulio.benetti@benettiengineering.com>
 <20230817220957.41582-2-giulio.benetti@benettiengineering.com>
 <20230817232348.GC1175@pendragon.ideasonboard.com>
 <28289906-4fd1-26aa-b1c4-eb393ac52d48@benettiengineering.com>
 <CAMuHMdVY7vaU8wpJrMD4HNkQwkJD0Rd9sL-xFDYXxJEcP91yuw@mail.gmail.com>
 <20230821075723.17944dcb@kernel.org>
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
In-Reply-To: <20230821075723.17944dcb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfLrOXLaxSQoGFCAtzm/aXGmv6eo4Swr2KzGwKu3Sb6ihJNuegyvMPiLMoibIT3o7aDcEqqEErKnlMb8zIgoU0pPRjwUmfa9qgL8I0hHBBNnwLF8Je/6T
 S7c5bMgCD8A+TOA+LKnq783N+KmAuUGGT0mOPZi2P4AyB+JFq8z9OxJqF0MpNpgEjNYuJjiXYlTv051FSzIhIgwzOn3gA2lzkFK97GVJIz+xCIsqbkiALDdX
 xn6kB1ZwPxSX+zWUnJQuvIn6M6U7ktjXoPA9fuXguhxsOfxboOCiygaDnx2IflQ7HbXI8uaTe/sv+Mt1mxtYxYkuj1neXCCqcIHPuPlawItlOBZFdccHoznB
 NaQ3QVUiXt+0nuoUhdahlCiiKycLc9lNWySKt9KdtoGaRCAb+jeRkXYs5cYAKLtViwMhkpiAvYajAtMYsIy7JLQSvQ7c/w==
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jacub, All,

On 21/08/23 16:57, Jakub Kicinski wrote:
> On Mon, 21 Aug 2023 09:40:59 +0200 Geert Uytterhoeven wrote:
>> Personally, I would respond "I'm sorry, but the only advertising
>> space we offer are Copyright headers (for employees) and
>> "user+customer@..." or "name (customer) user@..." (for contractors).
> 
> +1
> 
>> And this is a separate tag, so it's harder for the analysis tools
>> (whose output your customers must be interested in, too?) to
>> match the tag to the actual Author/Reviewer/...
> 
> I think that's a key point. Having a separate tag denote the sponsor
> would make analysis a lot harder. We'd need to start writing parsers
> with much more context awareness.

yes. There are already 2 ways to give credits I was not aware and I
will go with one of those.

Thank you for replying
Best regards
-- 
Giulio Benetti
CEO&CTO@Benetti Engineering sas
