Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00907A273E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 21:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237020AbjIOTdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 15:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237003AbjIOTdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 15:33:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1A419A9;
        Fri, 15 Sep 2023 12:33:03 -0700 (PDT)
Received: from mercury (unknown [185.209.196.239])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7B32766072F6;
        Fri, 15 Sep 2023 20:33:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694806382;
        bh=iSR+RPv5YIiANQT6etKaNwwRPfS7OeKIt4Bk3q/IhlI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ChOBdnPEl8HNmTPu8KQr9oU4ckmynn4JcyidoZQIg7xPCOPjnPxnIRLSUzXzNTpya
         elxEYjIcKyn+vzDREtMTS1ggvHz8hCjOz2GGtpO8mrBwU28E66VpZ0xRw3Fh0zjgu4
         rktn7g893TtbPJb8cFxMBN8cDMfajMKEOkP3kg4gxUvGIs4mT311+iYQuOTfCIE8RW
         OlGvPj3dPBB39nn/bN4pfWvj1LKOhT8PbefZz6AUHgcSV7Vi7FeNkvvC25/yFhyuG+
         UAnPgWtp9w5aGPQKnV/AkS64Gqx48e8Nhae1nklvSM8bz7t1+EVqxUKRKJZh5L+0Km
         C0JIZYEQ9UWkw==
Received: by mercury (Postfix, from userid 1000)
        id EF5A5106044B; Fri, 15 Sep 2023 21:32:59 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230621-topic-mm8013-v4-0-975aecd173ed@linaro.org>
References: <20230621-topic-mm8013-v4-0-975aecd173ed@linaro.org>
Subject: Re: [PATCH v4 0/3] MM8013 fg driver
Message-Id: <169480637995.562542.1597166089132918555.b4-ty@collabora.com>
Date:   Fri, 15 Sep 2023 21:32:59 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 15 Sep 2023 14:45:14 +0200, Konrad Dybcio wrote:
> This series brings support for the Mitsumi MM8013 Li-Ion fuel gauge.
> 
> 

Applied, thanks!

[1/3] dt-bindings: vendor-prefixes: Add Mitsumi Electric Co., Ltd.
      commit: dc2dc941730438250a5c6567b8685f065ce1dd0f
[2/3] dt-bindings: power: supply: Document Mitsumi MM8013 fuel gauge
      commit: 9d15ff53398b4b21198ee6dec4f65a251de881dc
[3/3] power: supply: Introduce MM8013 fuel gauge driver
      commit: c75f4bf6800bde67df22ac95139279ec8764118a

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

