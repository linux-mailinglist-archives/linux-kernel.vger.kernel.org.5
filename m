Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA37279DC44
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 00:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237818AbjILWwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 18:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjILWww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 18:52:52 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF7F10EF;
        Tue, 12 Sep 2023 15:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=4wV3+Ar5zGASt+xy1OWKP3yLmI4kNWQG0D12Wz808+o=; b=0hfhlp43bauXFbOgtra0mOctIE
        agRwLL58JRi/IvGki5VcucySiZFvRhYNOwqHhMPBGPLIndP7VJYdZXFEPPN3oNiYRmA+oehZBdTig
        KAb8jjIOkeDTTaEEB1utuPp6XyNES6gBK7zgpq2Amly54UKlzUW9p8MwQ3aZvXEDIZyQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qgCFC-006GXN-R4; Wed, 13 Sep 2023 00:52:30 +0200
Date:   Wed, 13 Sep 2023 00:52:30 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, kostap@marvell.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM64: dts: marvell: cn9310: Use appropriate label for
 spi1 pins
Message-ID: <0fd181d3-de5e-4e56-8176-faeb59a75fdb@lunn.ch>
References: <20230820225126.561304-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230820225126.561304-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 10:51:25AM +1200, Chris Packham wrote:
> Both the CN9130-CRB and CN9130-DB use the SPI1 interface but had the
> pinctrl node labelled as "cp0_spi0_pins". Use the label "cp0_spi1_pins"
> and update the node name to "cp0-spi-pins-1" to avoid confusion with the
> pinctrl options for SPI0.
> 
> Fixes: 4c43a41e5b8c ("arm64: dts: cn913x: add device trees for topology B boards")
> Fixes: 5c0ee54723f3 ("arm64: dts: add support for Marvell cn9130-crb platform")
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
