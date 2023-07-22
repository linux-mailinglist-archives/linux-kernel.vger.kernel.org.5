Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A966E75DA1F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 07:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjGVFPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 01:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjGVFO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 01:14:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D10E3C0A;
        Fri, 21 Jul 2023 22:14:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DB0360B05;
        Sat, 22 Jul 2023 05:14:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0649FC433C7;
        Sat, 22 Jul 2023 05:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690002862;
        bh=Y9SeIWbk2YIOGFD6Uv/zsynoXfdu9+hUWAqc+UmzSNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h3SiBJzeGjVjc+tetTErDFsNhuhRZ25pCINhei9pr0kUn+DzQ5GLMMEjZeDTxY1nS
         xnLD2p1QhOGOEAvL6AUCwxvKpIWHXx73xjKUfVRJ5/gva9V4Em7AWCrLCUWv/VbnmJ
         39tiEsVMjq72YQ9ROFSFoynxbStsMwGr+GRecEPNLt2t4hivc+DjhpiJm9sI/x11pw
         56YYs/qfIslfYWMrb7Pv4lS2ALeie2Q+fZ9s8UuhZdjUNuNt3rbczY2PG4XcZZocKx
         EhvX7xYGyjy0tIhGy9rkCQIKxrG2hZF8xQ0FC7Arv7xqyi7h6R1wEGrLFZL901tsPF
         GcnnakuGk31BQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Devi Priya <quic_devipriy@quicinc.com>
Cc:     quic_srichara@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_anusha@quicinc.com
Subject: Re: [PATCH] arm64: dts: qcom: ipq9574: Use assigned-clock-rates for QUP I2C core clks
Date:   Fri, 21 Jul 2023 22:17:20 -0700
Message-ID: <169000304218.3611206.6321329907362072291.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230615084841.12375-1-quic_devipriy@quicinc.com>
References: <20230615084841.12375-1-quic_devipriy@quicinc.com>
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


On Thu, 15 Jun 2023 14:18:41 +0530, Devi Priya wrote:
> Use assigned-clock-rates property for configuring the QUP I2C core clocks
> to operate at nominal frequency.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: ipq9574: Use assigned-clock-rates for QUP I2C core clks
      commit: 5229c1d6a0c7d7d8f51a27833e568909b8707c39

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
