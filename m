Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9023776A51F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 01:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbjGaXuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 19:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjGaXt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 19:49:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75441702;
        Mon, 31 Jul 2023 16:49:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 490BA6135E;
        Mon, 31 Jul 2023 23:49:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77D9C433CC;
        Mon, 31 Jul 2023 23:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690847386;
        bh=UtspiLMHTw4WkMywKnnMZEyt4/5nJFxr10jqrFNd93o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hIYbHCadk32crGSzhWq76u1X23eKhkQnIAbA+Ix0eAlP4fISPgrZf0uWHGT64hoF2
         xK6VzQVYtS8ZJMbrm/rRTucPYMnaVX2w6OYCWZO/wTotF0hoiHyUXXo1RFbtiNKIFM
         XYozEWYdYXlUVJEB3JlEqv/Xz+j5bP46u4dJ3jWv7p8F3am66hUS/CTXD5T6ZeWx33
         2P3P9sA2Z8FecrjX4QHcDIsLIO4etXMDrwF8cAOEGleqTe2ZqIWyz7Ol5IaqoaOjVj
         9xkG8ZTm9pstJ8zP7MB/yZb7ZdK/BXrQKgIw53s1Ms9K1S9lkM+sVW5anFX8nYPaqy
         lv/isxALJ/lfQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Kathiravan T <quic_kathirav@quicinc.com>
Cc:     quic_saahtoma@quicinc.com
Subject: Re: [PATCH V3 0/2] Drop the IPQ5019 SoC ID
Date:   Mon, 31 Jul 2023 16:52:44 -0700
Message-ID: <169084756384.3010488.4990153008297801691.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230724083745.1015321-1-quic_kathirav@quicinc.com>
References: <20230724083745.1015321-1-quic_kathirav@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 24 Jul 2023 14:07:43 +0530, Kathiravan T wrote:
> Kathiravan T (2):
>   soc: qcom: socinfo: drop the IPQ5019 SoC ID
>   dt-bindings: arm: qcom,ids: drop the IPQ5019 SoC ID
> 
> drivers/soc/qcom/socinfo.c         | 1 -
>  include/dt-bindings/arm/qcom,ids.h | 1 -
>  2 files changed, 2 deletions(-)
> 
> [...]

Applied, thanks!

[1/2] soc: qcom: socinfo: drop the IPQ5019 SoC ID
      commit: 90158bc118f6f09fd5cd412c5954a40fd032aeff
[2/2] dt-bindings: arm: qcom,ids: drop the IPQ5019 SoC ID
      commit: cb160cd7b11d0080d6bd21f1ea97c6edd2ae295a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
