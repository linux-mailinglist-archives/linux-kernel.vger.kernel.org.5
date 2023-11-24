Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161C77F7543
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345377AbjKXNd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjKXNdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:33:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D5F1BDF
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:33:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3529C433C7;
        Fri, 24 Nov 2023 13:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700832793;
        bh=leOqL5cP18fpDrM9XuEjcsZ1EgYyutXl9SkvhNNicbg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=MP8Q35ifrSXBaCqY8/B9mycqEaJUeDG3+yvaE644sfy0zvNA49QhgI4EGlsrzjSR1
         777QvA5F/9cIIRFL2jIQzPTgCdlcZ9iKC4qeyJLePoDbf7bymRlBKdzyHZj1iaAV5/
         H39lK5BxZUYlvk82lKxJnl4nj+w3ptqdld65hDufjr0PeS2Nl8UJ42v+GakB3a98rz
         tIDIroDBmXWZ0QNQKxYM9f82h7Tgz5ADt7gplZ7JomaD+TjO4JvPO8SvCRnU8jM8B9
         TlfFMAQvraMOcTmALV9ZAps5pHug411qJ9pWozrjwC38GIgunh9q69inUg626x2Ovi
         jfHsyvS0QZgbg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20231102203922.548353-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20231102203922.548353-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] dt-bindings: dma: rz-dmac: Document RZ/Five SoC
Message-Id: <170083279036.771517.5485533645571949188.b4-ty@kernel.org>
Date:   Fri, 24 Nov 2023 19:03:10 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 02 Nov 2023 20:39:22 +0000, Prabhakar wrote:
> The DMAC block on the RZ/Five SoC is identical to one found on the RZ/G2UL
> SoC. "renesas,r9a07g043-dmac" compatible string will be used on the
> RZ/Five SoC so to make this clear, update the comment to include RZ/Five
> SoC.
> 
> No driver changes are required as generic compatible string
> "renesas,rz-dmac" will be used as a fallback on RZ/Five SoC.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: dma: rz-dmac: Document RZ/Five SoC
      commit: 56d02cfa3fbfca7466ccd68f4db78b0297f5c01f

Best regards,
-- 
~Vinod


