Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC20E7B6D36
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbjJCPdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjJCPdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:33:41 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879A095;
        Tue,  3 Oct 2023 08:33:38 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4BD8E6E2;
        Tue,  3 Oct 2023 15:33:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4BD8E6E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1696347215; bh=wrUIBIBF70pQpH9AG4CLDBT6UzO9ydi22FmoxMPhVyY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=YHT1tiQgjh+VPNa73fxf18TfxhMWtWMVkS06IWUr99x+Jh9OJs9b5KIbcp9x0R1C9
         bjltukpsAwFLgvL/+4ddW0AR/Sm3ejLqkP42NbH2AW4C/SIoAQEIYinF6P56sEtWZN
         uA4eosAAudtNkVfIc3rtUQoNKURhsYAJ4/uUFk5JX5o63yso2/wYHypBzjZ2HmvZ9I
         /rKQSjoXn7cG5qKx8Ch8ttIkMSxNwHbJyeEU1E2amq1wWEu2QFIqzbn/xOilDRM8CS
         aFTP0X7a4cqb/ypmnNgIiJVe41nE0iR0pmuSfqqmltZW5e1XRWdVD7kFQ2SjyuUFse
         Urp4U7N9j37gA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     Javier Martinez Canillas <javier@dowhile0.org>,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] docs: submitting-patches: Suggest a longer expected
 time for responses
In-Reply-To: <20230913-submitting-patches-delay-v1-1-a2d48c5ca205@kernel.org>
References: <20230913-submitting-patches-delay-v1-1-a2d48c5ca205@kernel.org>
Date:   Tue, 03 Oct 2023 09:33:34 -0600
Message-ID: <87y1gjen5d.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Brown <broonie@kernel.org> writes:

> While some subsystems do typically have very fast turnaround times on
> review this is far from standard over the kernel and is likely to set
> unrealistic expectations for submitters.  Tell submitters to expect 2-3
> weeks instead, this will cover more of the kernel.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  Documentation/process/submitting-patches.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

I was hoping to see some more comments on this; it is a fairly
significant change in the expectations we put on our reviewers.  Oh
well, I've applied it.  I wonder if we should add a note saying to look
at the maintainer profile for the subsystem in question for more
specific guidance?  Of course, it would be good to have more of those...

Thanks,

jon
