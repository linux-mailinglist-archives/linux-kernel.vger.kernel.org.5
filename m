Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3730E8064A8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376417AbjLFCBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 21:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjLFCBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 21:01:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4128C9A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 18:01:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BCAC433C7;
        Wed,  6 Dec 2023 02:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701828067;
        bh=9OHaRiDicxhXQh9Mc1ZyeyO0pleLHfeIHHRN5jyLtNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d9B9kSBiOHAkVFDkotclHHIboTHIhCebaNcJJ8O+NJBA31OKscDy3xaQv1bL7b42D
         O5T5rd4avutdi9j/v3etMvtKm2MFqQKu36O+EHFiwmmjQKN18Yc6xYkFjoQ1zebBLz
         vnsO3+jX/Iq0GvU1S4w7GPkvuxgozTbPtx4zOd3fwaGvriK4AyXZM9QfhepD5h1jXX
         ixiaTM7F3NiHGwbep5AXjtnQ3JhU0d4kIWRuDF+gUcwDDMO5J2XljQPV7rXBKto+sl
         FFHutRrQ9EaCDO278z/GBS/EsCMoT3DCYxVW+JZidKZ7r8pTZZT1vFvf90LrvYy+lG
         9ZRqJA/rRwZ0w==
Date:   Wed, 6 Dec 2023 10:01:02 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [PATCH v9] ARM: dts: nxp: Fix some common switch mistakes
Message-ID: <20231206020102.GF236001@dragon>
References: <20231127-mv88e6xxx-nxp-v9-1-69f3f783f4af@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127-mv88e6xxx-nxp-v9-1-69f3f783f4af@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 04:55:20PM +0100, Linus Walleij wrote:
> Fix some errors in the Marvell MV88E6xxx switch descriptions:
> - switch0@0 is not OK, should be ethernet-switch@0
> - ports should be ethernet-ports
> - port should be ethernet-port
> - phy should be ethernet-phy
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied, thanks!
