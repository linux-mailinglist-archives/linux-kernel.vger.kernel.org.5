Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66DDC7F9794
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 03:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjK0CnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 21:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjK0CnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 21:43:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D202DA5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 18:43:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D3BC433C8;
        Mon, 27 Nov 2023 02:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701053005;
        bh=5b9VS7f/K9dde70o1iJ9/Cmwsu92ztvC2aXIF2oskn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rOEzeulHL68+6ecmh+q9CWqkyj+cdRZ0w8oOwC4vRNBlZEe1ZQtT9h2IVHATcj7xv
         AQ9v/K7354uuhER8BjqSrI6PTL6KRITx4GoX7raoeNtO8kQPysx7TP9Uan1wfVYf5J
         WAXdVkBYSk4YSoDzgRV56BBOjCvY7Jh9jzRCWsWirhlMmCoYLi94G1iNmDVoOuUkbs
         t6YxnagucV+d1udhOhODBNRUkK3CsaaNRdt2Epai68xX6miwOQlsENfjEf11UjEW5F
         7vbDanAhFm/nZgQK1W9SxdyaQBgCtJN0TXpHCr5TSqRvCtaweFZpt0AUNy/ym1g25I
         hY7wlQgVoqy/g==
Date:   Mon, 27 Nov 2023 10:43:19 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH] arm64: dts: imx8mm-venice-gw72xx: add TPM device
Message-ID: <20231127024319.GM87953@dragon>
References: <20231018180838.2164177-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018180838.2164177-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 11:08:38AM -0700, Tim Harvey wrote:
> Add the TPM device found on the GW72xx revision F PCB.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks!
