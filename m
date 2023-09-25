Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D967ACD7D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 03:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjIYBNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 21:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjIYBNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 21:13:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4813CA;
        Sun, 24 Sep 2023 18:13:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E9EDC433C9;
        Mon, 25 Sep 2023 01:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695604390;
        bh=Wmz48UIlp2PC5T1iQz6rVBuxFVOUZ6YblW0qZ4yZewQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m74P3FZ9MNSUw+ugowyh7SlhphwEjH2qhoh4JsqgBOodaRKVV2TQ5PXk0DLtlR0bW
         MkJ2rfz01I5kZsfJDj8SUHDXsdNUrBJ+XmKMVswChappzRYtEvQm2SAV+WBpsSFzTZ
         70Fg6leER1yYOJGoLKeQNn8DPAeRVtgkgWs3pfthi1tSykXsdD00/SjpCGGHdY59xY
         AHP5Q0NCjAjNZuLmTQ70trQj5DFFS/m7OOu9E0D2GnT8+68+8Bg5oIp6jqNWj3eoeW
         x+dPDhWApsQBfS4+1XOpFcQpanmxqYbiIwdhSm8jZeW26N0EBD5kVLkseAJiLHvNDN
         Q61cbL9zbvO9A==
Date:   Mon, 25 Sep 2023 09:12:58 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, marex@denx.de,
        aford@beaconembedded.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH V3 2/3] arm64: dts: imx8mp: Add micfil node
Message-ID: <20230925011258.GD7231@dragon>
References: <20230831044431.250338-1-aford173@gmail.com>
 <20230831044431.250338-2-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831044431.250338-2-aford173@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 11:44:30PM -0500, Adam Ford wrote:
> The i.MX8MP has a micfil controller which is used for interfacing
> with a pulse density microphone. Add the node and mark it as
> disabled by default.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied, thanks!
