Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3417D2A69
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 08:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjJWG3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 02:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjJWG3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 02:29:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B48FDB
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 23:29:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6D4C433C7;
        Mon, 23 Oct 2023 06:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698042541;
        bh=9FFTyA/IN+1usMt39XOMXypfgiatVLpJUUWPvSRYpQE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=edZHsRJIbpx8t6abh7Ur86OpCFb8ExmK5+NSkbA4yoXq+dJq56GoOzZIiZEjuG1iu
         MT9K0GntLc9aE1J6gKd8/h2Ylg3xe3vKeQbrnZi61NSP5BOw9aRT6OCksEbqTSgEPW
         JmJVNRbJWSNpcyr9rfHkHU9IeD+9p+PHrnGvFCdxO/ykoBfcUORvwj663F2VP1AAYE
         N0wcPoua109WYEElsHfTNnjCV0PjXLrkfk8UnPhelNzrhWQUCXomsw7JlgmES1krC2
         be9ERESrE9SSO9GYQ9mEMZfMhDRHdUitmIdEm/7873Hm1xtpT12nXpTau7eIACl175
         4HKBx3vlOQGzA==
From:   Vinod Koul <vkoul@kernel.org>
To:     devicetree@vger.kernel.org,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
In-Reply-To: <20231022163006.803800-1-sergio.paracuellos@gmail.com>
References: <20231022163006.803800-1-sergio.paracuellos@gmail.com>
Subject: Re: [PATCH v3] dt-bindings: phy: ralink-usb-phy: convert to
 dtschema
Message-Id: <169804253768.383714.5625853416046934960.b4-ty@kernel.org>
Date:   Mon, 23 Oct 2023 11:58:57 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 22 Oct 2023 18:30:06 +0200, Sergio Paracuellos wrote:
> Convert the ralink-usb-phy bindings to DT schema.
> 
> 

Applied, thanks!

[1/1] dt-bindings: phy: ralink-usb-phy: convert to dtschema
      commit: f5d5a0b5553aa1a4e165e6fc6c582db487768846

Best regards,
-- 
~Vinod


