Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42FF7558C4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 02:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjGQAN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 20:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjGQANx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 20:13:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359DF1B9;
        Sun, 16 Jul 2023 17:13:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD21960C61;
        Mon, 17 Jul 2023 00:13:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC4FC433C8;
        Mon, 17 Jul 2023 00:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689552832;
        bh=m0J0EubtXNhxN5nmYq/XAJuOb73a2atG4NNK7KrAfXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rs3lOSv1M2iTnPnjFBsf1RnBx6DSECfz5aZweHOHmjAeJsv5qg6iAJdD5g5qvAStr
         5xys7thLD8HreV9p1DMZVneFDsthJzDtkfuyjdDzbadQlwyP3J89ERBDp4BxEUbt9+
         EheHLs0h1n8aSAm15YLF4mEBnZkE2HcsAvDeNAhw76MBCmY/xBhAYliiJIOWAKKJwQ
         lTYHgZxpNP+MLECMnLnuhj/6q2wk9vbTeE/0qJiXqs+IbmXbz1eenDAywN1bKTWE6T
         ldQAq6q1+RZ82rKdY6pv4irV6HUANwlKU5k9g0RejWhBMc0cs9goPKwEMhpEnGWjht
         7t82OE3V01SGg==
Date:   Mon, 17 Jul 2023 08:13:41 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8m{m,n}-venice-gw7902: add SDR50/SDR104
 SDIO support for wifi
Message-ID: <20230717001341.GE9559@dragon>
References: <20230606153550.1449000-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606153550.1449000-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 08:35:50AM -0700, Tim Harvey wrote:
> The GW7902 has a Murata LBEE5H 802.11abgnac / BT5 module based on the
> Cypress CYW43455 which supports SDR50/SDR104.
> 
> Add dt pinctrl for the 100mhz and 200mhz states to support SDR50/SDR104.
> 
> While at it add the dt node for the CYW43455 wifi.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks!
