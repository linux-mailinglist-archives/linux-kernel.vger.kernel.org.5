Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B327A82E8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236634AbjITNHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236479AbjITNGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:06:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58ABF114
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 06:06:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C61C433C7;
        Wed, 20 Sep 2023 13:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695215190;
        bh=G21DTWBZn+yTyu1rRKh0URQEK1vCIDAO0T03Nvv7ZtU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=PS8YpdU7jShi0U537v+hU2/OhXwlVf3WiCM+5BFObDNygN2H5ZSw754ENjVT12zHT
         5Q1B5wpNdq0HilyuldvlQ1ogeosEeubO0oPpDEyTvcBQwEOv04Z8ruPNdX1TiZFS0V
         uTBm5MX5w4VxQYy3tYceHZCMy059kg0Puz6C1dQw5GGRtH3UUxt97RAWJuHwc4aSEl
         Ednlt9bchhiAMmpd96U7pShPYQRvHHjSrYFQRncW4KnzIgvWOnP926HvjVKkn2gHq4
         cu+s3bJunLbK+2Lj4eUymblPy/RYdFfEcH8lw+CYqvW2exoXBMLE6dejn/UiF/bDvN
         K1t00T2BskQfw==
From:   Lee Jones <lee@kernel.org>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Aradhya Bhatia <a-bhatia1@ti.com>, Andrew Davis <afd@ti.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230911142556.64108-1-afd@ti.com>
References: <20230911142556.64108-1-afd@ti.com>
Subject: Re: (subset) [PATCH v2 1/2] dt-bindings: mfd: syscon: Add
 ti,am654-dss-oldi-io-ctrl compatible
Message-Id: <169521518749.3428172.8999036795849348805.b4-ty@kernel.org>
Date:   Wed, 20 Sep 2023 14:06:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sep 2023 09:25:55 -0500, Andrew Davis wrote:
> Add TI DSS OLDI-IO control registers compatible. This is a region of 5
> 32bit registers found in the TI AM65 CTRL_MMR0 register space[0]. They
> are used to control the characteristics of the OLDI DATA/CLK IO as needed
> by the DSS display controller node.
> 
> [0] https://www.ti.com/lit/pdf/spruid7
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: mfd: syscon: Add ti,am654-dss-oldi-io-ctrl compatible
      commit: 9cfffe6a730feea95e7bc827537f5b0a2931171c

--
Lee Jones [李琼斯]

