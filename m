Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB8775B374
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbjGTPvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbjGTPvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:51:09 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6574A123;
        Thu, 20 Jul 2023 08:51:08 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E8364733;
        Thu, 20 Jul 2023 15:51:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E8364733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1689868268; bh=koaFNtpbcHava0Y0C+gpeyC1x0C0S3Ay62GAGr7//R8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=RWiS2lyreGWqPC+Nf2p0NUGM/O3jbrMb5VKac5CW/T5pq3spNIihAMCKyT6L4M/CP
         QrXpMWxxdJ0mu/wtKb/v8kzyMejsw40YykRxTji9xLou4D14K9rCYJ9Z2NqwlyrA0D
         uZTxPkGYASqJsxjr+P04+lLDH8aNiT3TK+zotLVVRMBa5r8VJI2MWHz3rOXuLDejYy
         18pkHc7udrDGjU7GCI+V8JMWfWZySDieMLkXmgIF5eWNIZIeu9nuuIEkcmRdspyS57
         TskUf+kUhrrp1CkpksyiLLd2amQ1xaviMbYD/3U75qFKAmqu8i3GCB22CbIiL69W6u
         c3brPKssZYoWQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Hu Haowen <src.res.211@gmail.com>
Cc:     linux-doc-tw-discuss@lists.sourceforge.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 0/6] docs/zh_TW: update zh_TW's documentation
 from an ascensive aspect
In-Reply-To: <671503c8-c5c9-f475-1085-2a5c551d74ea@gmail.com>
References: <20230720132729.1821-1-src.res.211@gmail.com>
 <877cqur8l6.fsf@meer.lwn.net>
 <671503c8-c5c9-f475-1085-2a5c551d74ea@gmail.com>
Date:   Thu, 20 Jul 2023 09:51:07 -0600
Message-ID: <87h6pypono.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hu Haowen <src.res.211@gmail.com> writes:

> On 2023/7/20 21:55, Jonathan Corbet wrote:
>> Hu Haowen <src.res.211@gmail.com> writes:
>> 
>>> Update zh_TW's documentation concentrating on the following aspects:
>>>
>>>      * The file tree structure changes of the main documentation;
>>>      * Some changes and ideas from zh_CN translation;
>>>      * Removal for several obsoleted contents within the zh_TW translation
>>>        or those which are not exising anymore in the main documentation.
>>>      * Replacements for some incorrect words and phrases in traditional
>>>        Chinese or those which are odd within their context being hard for
>>>        readers to comprehend.
>> 
>> Is there a reason why you're resending a patch series from four days
>> ago?
>
> Considering for a long time but no reply, I just thought my patches were
> ignored among the flood of emails or regarded as spam information.
>
> Accordingly I resent my patches to ensure the reception of my patches as
> well as added the cover email to provide an outline of my patch series.

Four days is not long enough by far; I'll get to it.

Thanks,

jon
