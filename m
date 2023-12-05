Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208DB804E0B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbjLEJi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjLEJi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:38:26 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AFA9A;
        Tue,  5 Dec 2023 01:38:30 -0800 (PST)
Received: from i53875b61.versanet.de ([83.135.91.97] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1rARsp-0006NF-Vz; Tue, 05 Dec 2023 10:38:28 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the rockchip tree
Date:   Tue, 05 Dec 2023 10:38:27 +0100
Message-ID: <4824013.9PvXe5no7K@diego>
In-Reply-To: <20231205152619.0ee82148@canb.auug.org.au>
References: <20231205152619.0ee82148@canb.auug.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 5. Dezember 2023, 05:26:19 CET schrieb Stephen Rothwell:
> Hi all,
> 
> ommits
> 
>   d892a562110e ("ARM: dts: rockchip: Enable GPU for XPI-3128")
>   2cc98b5080f6 ("ARM: dts: rockchip: Add GPU node for RK3128")
>   5e806176a3a5 ("ARM: dts: rockchip: Add power-controller for RK3128")
> 
> are missing a Signed-off-by from their committer.

sorry about that, I've added the missing Signed-off-bys now

Heiko





