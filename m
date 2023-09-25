Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F197B7ACDF9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 04:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjIYCMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 22:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjIYCMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 22:12:01 -0400
Received: from out-202.mta0.migadu.com (out-202.mta0.migadu.com [91.218.175.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571C4193
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 19:11:55 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1695607913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gv+uafqaxdaZgt/RSDYyi9C7m8D3DymG7MRuMChltow=;
        b=YWs5pGYMd+dRD8Qyiiih1AuF22KRu13DKM6DqbOM/k+3M8Sc8qCYwFYNjYxs08l3KUzxGK
        FOx/Nrh51hSfPbukJYr7xS9hE0iErhScAWcUawXkT/4YZoHOLpVHJtSffcn6GblyApb0y6
        JsHNCtsE1YDhOaDBaRzt1V1eRufeTaQBkD1+eqkYUtht8hp3CuQJzU6KrD3J+yx4hB/kDe
        iV0aoRe1ijsv69Hs8YZNWnVu+2W/EVnxuAQ9V4dJgg269KaY1tz0Zi8GItF/XIzSg60Pol
        z95GCuDMRzygBOD4ODNM8TeiX2v6j4NZv5plr0+Cr4WhZt9vyncRYZvuOCzlfg==
From:   John Watts <contact@jookia.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>, John Watts <contact@jookia.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFC PATCH v3 6/7] dt-bindings: vendor-prefixes: Add fascontek
Date:   Mon, 25 Sep 2023 12:10:57 +1000
Message-ID: <20230925021059.451019-7-contact@jookia.org>
In-Reply-To: <20230925021059.451019-1-contact@jookia.org>
References: <20230925021059.451019-1-contact@jookia.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fascontek manufactures LCD panels such as the FS035VG158.

Signed-off-by: John Watts <contact@jookia.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 565b13fb429d..744317e2a7cb 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -468,6 +468,8 @@ patternProperties:
     description: Fairphone B.V.
   "^faraday,.*":
     description: Faraday Technology Corporation
+  "^fascontek,.*":
+    description: Fascontek
   "^fastrax,.*":
     description: Fastrax Oy
   "^fcs,.*":
-- 
2.42.0

