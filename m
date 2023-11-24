Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1707F752B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjKXNcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjKXNch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:32:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCB41702
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:32:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64500C433C8;
        Fri, 24 Nov 2023 13:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700832764;
        bh=IVT7swiiMslQOoYmCSZAuXzD5cIHDs9WbVN/4614sJ8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=IF+DS6vnjgK4tDKl209LlG0bTkxcAyiUD9vW2GaEuTtVVy9YHb3FEHznwU5SHkhU6
         YfbP0Y1Zxl00EaLNKixqgNTWUxxZfhmKMGuCBgRrhdZjJAkW/7VBVbN/c9XlFSonzn
         f3IzTfFn6iI4ZOiLfbGu2NfMFADXs+fywgP9mNAij50janoEwpF9wbr3KJaJpORbJf
         NZ7QxxJ9+BJU0XWrJAnpoB3XKx8DRynhcvZcls3UsvXLkKitsPvNnitGMFUS8MyydI
         HPwyuao1C+epxP1jKq1YCnNHaqkPq1GjCE+S5Mmo4XG8hM6nBmd8EpghUirv1cOti9
         tbhhGVvNItFjg==
From:   Vinod Koul <vkoul@kernel.org>
To:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Ronald Wahl <rwahl@gmx.de>
Cc:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Ronald Wahl <ronald.wahl@raritan.com>
In-Reply-To: <20231030190113.16782-1-rwahl@gmx.de>
References: <20231030190113.16782-1-rwahl@gmx.de>
Subject: Re: [PATCH] dmaengine: ti: k3-psil-am62: Fix SPI PDMA data
Message-Id: <170083276202.771401.991990874287880662.b4-ty@kernel.org>
Date:   Fri, 24 Nov 2023 19:02:42 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 30 Oct 2023 20:01:13 +0100, Ronald Wahl wrote:
> AM62x has 3 SPI channels where each channel has 4 TX and 4 RX threads.
> This also fixes the thread numbers.
> 
> 

Applied, thanks!

[1/1] dmaengine: ti: k3-psil-am62: Fix SPI PDMA data
      commit: 744f5e7b69710701dc225020769138f8ca2894df

Best regards,
-- 
~Vinod


