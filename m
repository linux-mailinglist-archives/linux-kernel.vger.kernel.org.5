Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7848D7BF0DF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 04:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441850AbjJJCZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 22:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378796AbjJJCZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 22:25:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687B89C;
        Mon,  9 Oct 2023 19:25:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26845C433C7;
        Tue, 10 Oct 2023 02:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696904731;
        bh=qDFAIZJBZaNLR6S/I5Pe62KY//2o+PXQuDVr5YqKROg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TdATxuCPTumxA4f6U0UOWfIcKsCH+Y+whTQgEUoHmZhwWOiMxA3BMYU2UMiZ21nWh
         zRvp4SzjZvdpjIUlfYiLUMwd4l6k0lTT/PmjkN+JSytmxp7dUec6a1XAWqPQOOeIIi
         Vn5+XxqY8jjPThmH74TDBYJQBGIxG6ZSULAAztmHXLraLY4sdNgUrc9NYJJVDROpir
         +y7ogVkffDbX3YhD9+EjGZi21Z2AK52/KDnYZs2OvvLemqfS3BfdAdDrK6PIt86L5s
         JJRmMkM4+OX2bqj44KV3f0uUaha766VvTyhHb1iAQF+omNadOsf2fdj62BkC1AfOM1
         fFxGrkAWh2rSA==
Date:   Tue, 10 Oct 2023 10:25:17 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V3] arm64: dts: imx8mp-beacon: Configure 100MHz PCIe Ref
 Clk
Message-ID: <20231010022517.GJ819755@dragon>
References: <20231004235148.45562-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004235148.45562-1-aford173@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 06:51:47PM -0500, Adam Ford wrote:
> There is a I2C controlled 100MHz Reference clock used by the PCIe
> controller. Configure this clock's DIF1 output to be used by
> the PCIe.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks!
