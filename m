Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680EF7A8A11
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 19:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234748AbjITRKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 13:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjITRKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 13:10:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2AAA3;
        Wed, 20 Sep 2023 10:10:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2144BC433C8;
        Wed, 20 Sep 2023 17:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695229807;
        bh=4/QpFdXXat5YYWLWJXquh/jNvMlFGIeOXDZXtyrqkL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FNXtXmMEtJ33lUPlF8cl/BbOYVSD5+rxt7WgqlwIDrVGwixMgEXspGeBc3Mnr33IO
         u7A1bjSASIYByr+Egg8GcA4fNFpNinYK5nJTPVNqJocdKevxQcJe05xMR7TZsHT/IW
         xL2SrHt/d6nyNx0LJt60N8yZJnGvhJzWiXJMWJ1OLvHDGPcj4ie3qArha+xSotz+3a
         0/w74WSiubSuA/LhhVpfEcQzNsaGhEGleoO6hUXc3MznIl5D9sehkBTJF6Ru/J5nWi
         hjz74eSVWuguXSAHuvtTLYTToQWH+Oj6eHZUO3xJzkEaMNhKWhqYSnocDS5vs+HEay
         8f4ahemZqTqBQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 1/2] dt-bindings: crypto: ice: document the sa8775p inline crypto engine
Date:   Wed, 20 Sep 2023 10:13:55 -0700
Message-ID: <169523004971.2665018.5457570667421710137.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230913153529.32777-1-bartosz.golaszewski@linaro.org>
References: <20230913153529.32777-1-bartosz.golaszewski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 13 Sep 2023 17:35:28 +0200, Bartosz Golaszewski wrote:
> Add the compatible string for QCom ICE on sa8775p SoCs.
> 
> 

Applied, thanks!

[2/2] arm64: dts: qcom: sa8775p: enable the inline crypto engine
      commit: 96272ba7103d4518e2d0f17daf6fe0008fc6e12c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
