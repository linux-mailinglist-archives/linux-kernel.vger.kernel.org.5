Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A247F5ABA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 10:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjKWJFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 04:05:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKWJFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 04:05:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBED12A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 01:05:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517C6C433C8;
        Thu, 23 Nov 2023 09:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700730319;
        bh=l6l7rfNq9C2pJ8qB1srfSPaHh2HKOoGwoK/QaWH8w+o=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SRjMaWL/92cYdhNlQ885lbenxszEoiFC7usN8UAnmAzplSCGGVhkyA7DbBI9Sc+42
         yf+dkCw3nHh589t8rJw9E+i+Yr5fqRyuE7e5ibjCvk2tSSjqT3jO2UBJYjX+vjK2f6
         3PQui++wYwvzZtlhO2p49EITbVUkhMqPFzrAsIYe7jvbmTije9IEB+OP9eneTQMYLQ
         k/Wo3tZo6yqURBptLfCyrTwuAHVfJn8TZiS5NxZH/uaO2ymC3XyFtcV5NAEQqEaMTz
         6k8ZPWBtKYfaKsEU2WHbXRXP9zQUuXfbr8nGY9KuRzrqZBGqEQ2z86FS+F14KmJZXA
         2/wIX1GsTVE1Q==
From:   Lee Jones <lee@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <56a5ebee588696f9022fa29fa8e266c8bdee6fd7.1698228043.git.geert+renesas@glider.be>
References: <56a5ebee588696f9022fa29fa8e266c8bdee6fd7.1698228043.git.geert+renesas@glider.be>
Subject: Re: (subset) [PATCH v2] dt-bindings: mfd: ams,as3711: Convert to
 json-schema
Message-Id: <170073031703.1185179.18008578184817685295.b4-ty@kernel.org>
Date:   Thu, 23 Nov 2023 09:05:17 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Oct 2023 12:02:34 +0200, Geert Uytterhoeven wrote:
> Convert the Austria MicroSystems AS3711 Quad Buck High Current PMIC with
> Charger Device Tree binding documentation to json-schema.
> 
> 

Applied, thanks!

[1/1] dt-bindings: mfd: ams,as3711: Convert to json-schema
      commit: ad7531e58b88eb92032d11c166dd544c434ce3c5

--
Lee Jones [李琼斯]

