Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C307CB255
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 20:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbjJPSWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 14:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233985AbjJPSWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 14:22:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EC5EB;
        Mon, 16 Oct 2023 11:22:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2542C4339A;
        Mon, 16 Oct 2023 18:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697480529;
        bh=D3lvxz34unyH65s2yVEAdU7RQleW7M+mejIznp0HEb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D7xuNzYPgCr1PXU7ctKhvWMbKSBHbx6rhvV3wdFjYUXYY7V5gpTtZHwCI0pXcLEds
         P/Tv3RbHz55h81LpJUaeH8jaenvtmQ4WfQTx8HRf24nAVgSeTGQ7rGKPJZzfBTUHMv
         W8TqcVW2JmQSYf7+mbmlBdRNC2ugQohTSdc/h27l1VfLncFcAaZhZQMuPJGj6BwCZY
         3smPDpkhqQa6sGVVy/2QqaMz5aSadwCyaaQuixXb6EIkFPXLBMlLRRG70+CL8s+vXr
         bYz68LAS3sLq8U37iVR63Bhkj1Ii8znOJ52oNipYdXIduJZU5xy9Y10XVta/qV58i4
         HLmmu8JqoOIVg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Raghavendra Kakarla <quic_rkakarla@quicinc.com>
Cc:     quic_mkshah@quicinc.com, quic_lsrao@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3] arm64: dts: qcom: sa8775p: Add RPMh sleep stats
Date:   Mon, 16 Oct 2023 11:25:51 -0700
Message-ID: <169748074961.1245023.10066294124757569075.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230929054805.27847-1-quic_rkakarla@quicinc.com>
References: <20230929054805.27847-1-quic_rkakarla@quicinc.com>
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


On Fri, 29 Sep 2023 11:18:05 +0530, Raghavendra Kakarla wrote:
> Add device node for sleep stats driver which provides various
> low power mode stats.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sa8775p: Add RPMh sleep stats
      commit: f19a9a341d6faaf8d04bb6d9fb1f6a367ca0ed3a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
