Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B825676EF9A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbjHCQfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjHCQfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:35:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7A82698;
        Thu,  3 Aug 2023 09:35:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF08161E3F;
        Thu,  3 Aug 2023 16:35:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E99C433CB;
        Thu,  3 Aug 2023 16:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691080509;
        bh=/KsWYJjwREipe3CD3l11o2I/n2xRnHABPBoO29OSxag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rz666g/Yd1ejYTdSfPqJ+GjH54m5PqPmINIo1rlBfGs//HVCMm8B9mjGv632eYFCE
         LwxfUBZDpVblNDjsju5fD5giXctYqXm2LFzH52A8c1LOUwzSGOQOXklZB640Lk+YdY
         fJkni3pjrqxj0PWZf704rXH5dGKhqw4i/1bOOT5AwM6L++RBLmV1Y0qtGEtGWv2jZq
         UTFANvtC17GFZfLt4AGyRm2FFnSCsMxi3IbUogXt21xLzFL52TMxOSMsIWIUfNPQNc
         Fsk6pil4jtmgdfJZ8C+/LldI5xnQ2jKBOfxsPWz8ADfWp2cCgHIkgnTm76PmS6VrL2
         a6hd90Qrbh6dg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sm8550-mtp: Add missing supply for L1B regulator
Date:   Thu,  3 Aug 2023 09:37:59 -0700
Message-ID: <169108064635.108343.8570383964663569857.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801095246.2884770-1-abel.vesa@linaro.org>
References: <20230801095246.2884770-1-abel.vesa@linaro.org>
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


On Tue, 01 Aug 2023 12:52:46 +0300, Abel Vesa wrote:
> Even though currently there is no consumer for L1B, add the supply
> for it anyway.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8550-mtp: Add missing supply for L1B regulator
      commit: 2c9e45dfeed126488aa73e7b82b3576c4c6f1036

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
