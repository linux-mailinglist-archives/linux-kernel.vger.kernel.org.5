Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E34280A61B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574068AbjLHOvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574096AbjLHOvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:51:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDD01BC7
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 06:51:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E77C433C7;
        Fri,  8 Dec 2023 14:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702047078;
        bh=cG8W0M/t4/u1ISE9ZqR1C1c719aguQoxMpPo2EFRDE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X7J9kCQG7e3dktXVBofkt8WZ4LovJQJOpGTx/B+i6dV5T+40WUydnk4POSz47ntdJ
         4QLAQrcPx+yY0MLVWRSdxvqVFEuEZinmOaRXax6BFh/ASgTL8HPIW8A73ysHhC9EPA
         NCu/rJObyIPqRDW/2lXRpE1AnnXlsyloXPPyr1Qoa9cXjlcMt+5Rpkah2RSTkgYKG1
         0altbXr57gs8bM0TRny1reuEbkbqxI1K0S/yh+glwElYkJXvf0ZomuqsQONVdymenh
         2C7W897jpHkhzQAwA+5hhaDQS4iwZ8LDkbbhdWTVcuOs9xr7GlYauGDBwnnEGFb1FH
         /0aP3/9e98OlA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 0/2] soc: qcom: llcc: Introduce support for SM8650
Date:   Fri,  8 Dec 2023 06:55:27 -0800
Message-ID: <170204733614.342318.16799780457521942115.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231030-topic-sm8650-upstream-llcc-v2-0-f281cec608e2@linaro.org>
References: <20231030-topic-sm8650-upstream-llcc-v2-0-f281cec608e2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 30 Oct 2023 10:45:13 +0100, Neil Armstrong wrote:
> Add LLCC tables and Bindings for SM8650 platform.
> 
> Dependencies: None
> 
> For convenience, a regularly refreshed linux-next based git tree containing
> all the SM8650 related work is available at:
> https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm8650/upstream/integ
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: cache: qcom,llcc: Document the SM8650 Last Level Cache Controller
      commit: 8fa41c40a1cb8bd78e3aba36865162c8d7019d94
[2/2] soc: qcom: llcc: Add configuration data for SM8650
      commit: 7a280fec21fa4ca313e7aa6708f2480757501053

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
