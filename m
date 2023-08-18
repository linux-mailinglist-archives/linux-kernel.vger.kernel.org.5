Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB44780A3B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 12:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359850AbjHRKds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 06:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376339AbjHRKdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:33:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DDC558A;
        Fri, 18 Aug 2023 03:31:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B008E640A4;
        Fri, 18 Aug 2023 10:31:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2524CC433C8;
        Fri, 18 Aug 2023 10:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692354666;
        bh=ndPPycUmNOCCYOqfOXo/JaEow5hs7D6ZOxkE3o7r+4c=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=kdD3a+iwdCWYN0+Nl0UFrIp6h4yJQKFR1LBEdnsP8kjZFir9LsOA5qPeMYWdXahEn
         /YCLlkk46lkxGWX/KQ56wrv1e07MB2VyWmmsxjCKXoWx4p53ftgXQeraAifkW/420x
         kaX5cWlCyeJxx4Glsazr7HWiD7VfnpSZRNyQdgPdDo6h/A/kL/+6uc5DCFN1cFj3qd
         iAqcUvEY3F2O43EG7eQ7nVAcsa/A/mmKqZejrbcnmudQrp0h7HxRgb3b1BY1WFbFrU
         sMewgdoP02r3xh2wBLi8Hvj5H+GP1PYNET1MzRSdD824P3Rzn2iR0WJ7g7asJ4ImKS
         BFEie740wXOqQ==
From:   Lee Jones <lee@kernel.org>
To:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     Rob Herring <robh@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230814163116.1696092-1-j.neuschaefer@gmx.net>
References: <20230814163116.1696092-1-j.neuschaefer@gmx.net>
Subject: Re: (subset) [RESEND PATCH v3] dt-bindings: leds: Fix reference to
 definition of default-state
Message-Id: <169235466385.1241692.15168908576778455160.b4-ty@kernel.org>
Date:   Fri, 18 Aug 2023 11:31:03 +0100
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

On Mon, 14 Aug 2023 18:31:15 +0200, Jonathan Neuschäfer wrote:
> At least since the YAML conversion, the default-state property is
> described in leds/common.yaml, so there's no need to point to another
> file for its definition.
> 
> 

Applied, thanks!

[1/1] dt-bindings: leds: Fix reference to definition of default-state
      commit: d3679199f6847061683069d65737a55a8a5c60ef

--
Lee Jones [李琼斯]

