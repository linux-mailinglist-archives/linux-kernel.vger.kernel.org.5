Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DE5755D6E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 09:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjGQHtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 03:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjGQHt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 03:49:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB2CDE;
        Mon, 17 Jul 2023 00:49:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0C6960F90;
        Mon, 17 Jul 2023 07:49:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E2DC433C9;
        Mon, 17 Jul 2023 07:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689580155;
        bh=waKWJVOAVBelCCI1mB4poaxnZoLxRarS05iTbEu+fGg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ETvDL7REf0/QLPjSciqioJlqT1+t33+n0MsHYt3ZS5nlqHjalFVSULyueWDSepJDZ
         a46DVAA3dKgwxAjvszYB+hLxtPJD1X/rgMNPtfuf5hdqn2jsiKrzSrJfDhNHwRSJg6
         V0Uh9d0cJBX0uREL+nV3SHHXKD/coZHG4MNLn11h9ZkEKXvFzKsjo+zSsKHvYkdH3v
         fHlC6qyQk6G2/u5DWApyL3KQk622YrhFo0WZP/Mibs0WahAhiJlvWHs+726a2EyFVz
         3ura9Lcwiw7xZvHtGYlm8Xcl0CQ3PuZi0qM9x//tPcN/a7n49IXmpXwBaKsRgV32Qe
         xgne2JMBU4bAQ==
Message-ID: <895ed8ae-e93f-b296-330e-356cda698de2@kernel.org>
Date:   Mon, 17 Jul 2023 09:49:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH docs] docs: maintainer: document expectations of small
 time maintainers
Content-Language: en-US
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     corbet@lwn.net, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, Mark Brown <broonie@kernel.org>
References: <20230713223432.1501133-1-kuba@kernel.org>
 <6f1014cd-f8c5-f935-dcc7-4f5a6b85e473@kernel.org>
 <20230714101028.337fb39a@kernel.org>
 <bb8c6476-283c-3bc6-710b-5a8602ccd40e@leemhuis.info>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <bb8c6476-283c-3bc6-710b-5a8602ccd40e@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/2023 12:31, Linux regression tracking (Thorsten Leemhuis) wrote:
> [CCing other people in the thread]
> How about something like this:
> 
> ```
> Bug reports
> -----------
> 
> Maintainers must ensure severe problems in their code reported to them
> are resolved in a timely manner: security vulnerabilities, regressions,
> compilation errors, data loss, kernel crashes, and bugs of similar scope.
> 
> Maintainers furthermore should respond to reports about other kind of
> bugs as well, if the report is of reasonable quality or indicates a
> problem that might be severe -- especially if they have *Supported*
> status of the codebase in the MAINTAINERS file.

I like mentioning the "Supported" part. We should be a bit more
understanding to all folks who are not paid to do this.

Best regards,
Krzysztof

