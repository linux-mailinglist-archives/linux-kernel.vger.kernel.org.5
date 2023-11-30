Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14ED7FFB21
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376366AbjK3TVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376354AbjK3TVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:21:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31BD10DF
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 11:21:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E35FC433C8;
        Thu, 30 Nov 2023 19:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701372102;
        bh=xFJaBUGhTRuqos9uOdVZgNT7AXqJONxi3TV6qgLPhjE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ONSjEr2crneS7MCJyTlRbdfXdOwiyT4E+4vzk3eQZUeV5B2IWSlLEeSmx/7KNLNik
         2n1q3L9SKgyQYmHlHuBwEx0h2b45KVwD/ysN8R0Cf4T5EUgSQDa5/Ys88YZgaWOMng
         +gbFjLMXFAvhCAKDK+KpDxPri+bwTXZ63FE+DKJXEyafIV8mgHZe+v4kgEDxPXsgmn
         RTbIfGGYDayr01NBXDUcqBj3YBDMMASpARwE2ObSX1PlpKE2iWwjo6HccCcLWUgaNx
         SxpmD3i4KvVgUIVYR+QmXBWoPPoqhYDGQPceurVDJc2cJluIRR/O42tKnn1HvUx0yZ
         BPG9L2VO+kXtQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 6/6] bcma: Use PCI_HEADER_TYPE_MASK instead of literal
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231124090919.23687-6-ilpo.jarvinen@linux.intel.com>
References: <20231124090919.23687-6-ilpo.jarvinen@linux.intel.com>
To:     =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170137209833.1963309.16652947115996666871.kvalo@kernel.org>
Date:   Thu, 30 Nov 2023 19:21:41 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> wrote:

> Replace literal 0x7f with PCI_HEADER_TYPE_MASK.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Patch applied to wireless-next.git, thanks.

ac586b8401c9 bcma: Use PCI_HEADER_TYPE_MASK instead of literal

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231124090919.23687-6-ilpo.jarvinen@linux.intel.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

