Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE907C8376
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjJMKoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 06:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjJMKoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:44:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E854AE1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 03:43:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 635EAC433C7;
        Fri, 13 Oct 2023 10:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697193837;
        bh=JVPe1ma/Ed+P35neF7yaxCDpkQ3MjQ9w7c4PvaAOM+k=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ovVdzscBiTqQF0j21wfy3LIsCGZ7bRmRGAf+VU1txLKAcsz+sxslfdLI67h61WY/T
         yfpg8n7Cc9eyN9cj9xDv3CG2K07nIB5KdJc66tYeB8HlNbaoryNr62Wyhkvv0GUMeu
         EwWNNPHFaewzVZhqM8nQbIzUD6F9uYrFR6+LL1AkSxOXHYWNDVAUxF6XzVCDhcG6WJ
         HBFnv18WuJ3i1cvOUXi13u5YJyjdLgSIF/ErFjfcg6BphiAucV2t6uXq6GLzUOMzvB
         VhCEjzmnPeJZ97QIhKVDv97plGuSZ1wZF/v64QVMSGWN6w6itnV15vWEEXP7vAcR8Z
         2+9w00pg4aZYw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231004-pxa1928-usb-yaml-v3-1-150c9ef3ab9d@skole.hr>
References: <20231004-pxa1928-usb-yaml-v3-1-150c9ef3ab9d@skole.hr>
Subject: Re: (subset) [PATCH v3] dt-bindings: phy: Convert PXA1928 USB/HSIC
 PHY to DT schema
Message-Id: <169719383504.165658.18236925418957176222.b4-ty@kernel.org>
Date:   Fri, 13 Oct 2023 16:13:55 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 04 Oct 2023 16:34:43 +0200, Duje Mihanović wrote:
> Convert the binding for the Marvell PXA1928 USB and HSIC PHYs from TXT
> to DT schema.
> 
> 

Applied, thanks!

[1/1] dt-bindings: phy: Convert PXA1928 USB/HSIC PHY to DT schema
      commit: 03c866cab420e2e3381ca817be664e714107e39b

Best regards,
-- 
~Vinod


