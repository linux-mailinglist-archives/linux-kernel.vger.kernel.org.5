Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96697BF108
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 04:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441912AbjJJClv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 22:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441879AbjJJClt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 22:41:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A545693
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 19:41:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB92C433C7;
        Tue, 10 Oct 2023 02:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696905705;
        bh=wJyl+vl7uCX3sJfsgHZ7JIGdW4GsJzSvULqsNno3Xv0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BjeNM0mykjbK5Dn8eq8OViJUcKljkNpNa1ZkGIud8g+r9MKO4txVJl7rE/SotCswG
         6NfngInyPICijb9pIaTVAvJ79fKVl1vBvCJHx9nStGOllWdqpXckXifYGtmiXRh+rs
         3C1PTx/moqfPSkC20HQ2NNokrbgo4V0IOTN34wsbGSrNAZ8qvFy+aMIkVQYPvLAzDP
         YgnAh5ML7sA5mw2ctm5Fq9eYqqGAUjYrLt8iHAEHxQHPt6Wn+IzFxOzfNh4uzY6XaU
         Olq4eySG0Ble7btqwmye314zRRfftcwEcxNlNe0+bhXE7EkhhE+1X/b3/znpMYWh66
         uZYMvgmYSsPSg==
Date:   Tue, 10 Oct 2023 10:41:32 +0800
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
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/4] arm64: dts: imx8mm-beacon: Migrate sound card to
 simple-audio-card
Message-ID: <20231010024132.GO819755@dragon>
References: <20231008140239.6601-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231008140239.6601-1-aford173@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 08, 2023 at 09:02:35AM -0500, Adam Ford wrote:
> Instead of using a custom glue layer connecting the wm8962 CODEC
> to the SAI3 sound-dai, migrate the sound card to simple-audio-card.
> This also brings this board in line with the imx8mn-beacon and
> imx8mp-beacon.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Applied all, thanks!
