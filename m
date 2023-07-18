Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4B1757214
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 05:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjGRDKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 23:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjGRDKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 23:10:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C776EE51
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 20:10:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 296296138B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 03:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D848C433C7;
        Tue, 18 Jul 2023 03:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689649816;
        bh=6U8jMkHn1+LGrjsBEHO+IH5Vr6hqko1F9a9fqBzMIIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sVbGF/soeiczogHJ4w+nnCVfj6Mrs1WKCx+l1AqfzgtnE2TRNKBliQe25FCBj+tWZ
         o+LsEyStyjln8dqum1ryFknmj+D/MamBtt679ylsRTBCD7vqmkULlxgAeLpcPKKHuj
         jCYmAJJ21vBo7xWlGeyB08E+oOOYHhDMskDj7rZxatnBhCQ1NBVIr2lZCurmSzslEd
         +vnd78nmnxh1fReltDGo85MFQ9vW7QSOiS8mVmPVOTTzD2QaGx2xa1jRHvQWmp3fQw
         g7L7OXjI7tF9eQWQ2WLYtxT2RwaHW1JWqoZ0hCvtpJ2CL6mFy3HRS1XW6szz6VOv3Q
         UhS9xtUOEXtFQ==
Date:   Tue, 18 Jul 2023 11:09:56 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will@kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] arm64: defconfig: select IMX_REMOTEPROC and RPMSG_VIRTIO
Message-ID: <20230718030956.GA9559@dragon>
References: <20230625112939.4058616-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230625112939.4058616-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2023 at 07:29:39PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX8ULP relies remoteproc and rpmsg enabled to communicate with CM33
> for boot purpose, because some boot related things are handled by
> CM33.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks!
