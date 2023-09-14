Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE7E7A0A17
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 18:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241710AbjINQBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 12:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241581AbjINQA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 12:00:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132112113;
        Thu, 14 Sep 2023 09:00:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E94C433C8;
        Thu, 14 Sep 2023 16:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694707244;
        bh=s5eKT9LyYQ04iLn5WzeyeRWddRgwEAzl0R57g4chGYE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Q86ackW4mHDmCq1G3Ni6UfPswm6geToODxi7/rEQGRIneXHYdX0ak3AANS+RZ+DyB
         7uJEbhCB4N0pTTiVPT6v++QKocqWk7GcxH/PyKpe44GAiQkIaqoDkKJZrL8uh6RSyJ
         FCXoRSm2sAZloKnr5TUkmBjdUtm7zsIjj4ipz4xItE1TeAlUzel8OOZedoRAz1cFbE
         1Z1Qt35NQNrqAnxrrgD9JjTNpcnwaH9EaYAkaDpy4Ls0CQ5zDvQGtQwZXrQsfPdvF1
         JBq33jpqIo9b/dwSwSUhFYVXGV6GWQPTKq/G/vtDV5TEBarTo5tXSxDputV8ezjvrq
         ywdmuBowpGVHA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Robert Marko <robimarko@gmail.com>
Subject: Re: (subset) [PATCH 1/2] dt-bindings: arm: qcom,ids: Add IDs for IPQ8174 family
Date:   Thu, 14 Sep 2023 09:04:32 -0700
Message-ID: <169470744881.681825.5161252914219672681.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230901181041.1538999-1-robimarko@gmail.com>
References: <20230901181041.1538999-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 01 Sep 2023 20:10:04 +0200, Robert Marko wrote:
> IPQ8174 (Oak) family is part of the IPQ8074 family, but the ID-s for it
> are missing so lets add them.
> 
> 

Applied, thanks!

[1/2] dt-bindings: arm: qcom,ids: Add IDs for IPQ8174 family
      commit: b8c889bef9797a58b8b5aad23875cc4d04b3efd3
[2/2] soc: qcom: socinfo: Add IDs for IPQ8174 family
      commit: e9104e73d4fc8a023608be9c18ee1b897d0ccb14

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
