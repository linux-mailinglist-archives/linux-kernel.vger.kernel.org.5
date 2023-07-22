Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D8875DA13
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 07:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjGVFOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 01:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjGVFOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 01:14:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F6B35B8;
        Fri, 21 Jul 2023 22:14:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66FFD60AF5;
        Sat, 22 Jul 2023 05:14:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F259DC433C8;
        Sat, 22 Jul 2023 05:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690002857;
        bh=vt0tkpUNF9NGpc6pDs6azlbgj+S4y7S2vt8fNCPIT20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pc3qRLGO2vZ9ystb4b5gpLaSh+zKZEIbiWEAjxbf8V8ceqmb4wslTNvk6QjNlXkvF
         DqdhyMPlAO+OOB8ujQuNkBNaFmLZu+dXra5oSLFwgrxnyPgNK5AzGI/QxLaOkIEH2M
         IE6n0hTDPe0JrOZTGPvIz/O7DwhpQUg2xMgfKmObG9G+m61Nzp/lZinc4Y64DcGutc
         k/RFqIlilZ3WIHsSaVlU/3JCIwO/pwarj2Bf0uzjfw4rFkl/hAitM515TUCDvNtx51
         vWOJT8J49wZ6GbdnpPaLDKxIFtjV+V8mFK2qdKo27xmR6/PGWAX3yo7TmGLCCcTHQw
         I1j87d9L6XewQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-kernel@vger.kernel.org,
        "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v3] arm64: dts: qcom: msm8916-samsung-e2015: Add accelerometer
Date:   Fri, 21 Jul 2023 22:17:16 -0700
Message-ID: <169000304203.3611206.12263759141931260191.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716190807.7056-1-linmengbo0689@protonmail.com>
References: <20230716190807.7056-1-linmengbo0689@protonmail.com>
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


On Sun, 16 Jul 2023 19:08:24 +0000, Lin, Meng-Bo wrote:
> E5, E7 and Grand Max have ST LIS2HH12 accelerometer.
> Add support for it.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: msm8916-samsung-e2015: Add accelerometer
      commit: 3e9b36783b22327a4c88fe67b48b8fefae868a4a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
