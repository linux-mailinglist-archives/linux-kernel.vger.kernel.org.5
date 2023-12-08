Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F7F8099EA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 03:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573091AbjLHCy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 21:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573110AbjLHCyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 21:54:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B1E1731
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 18:53:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2858C433CB;
        Fri,  8 Dec 2023 02:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702004025;
        bh=WIghwBFnPfK3b0KldIVUfMhIxq24v7A2PN7RSq8O9KU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QYxOnLtfTVtz55lweH9URNHpbj5NsBoGzpLUuX23Tgrt7+6kUSUfcMV0lt665k1By
         IST9l+JSara5Htw4IvwYWAocqeVYDSIOoix2iq+I8O2Jk0RmhKYJqp3/OYUEd0gcFk
         oQ/jexfcvYWCvLGaGavzdhDdzKTRxoUQJR4otlX8k7eO/vEmRvc/yxPdB9uPgNMKKq
         hTw0VfqUmxHTXjo4D/Bch/F21a223Ss0dm/rE1ZxttfTeeAoWfniZKv57IbI9Zl6V2
         nnxwP/kLZAX/zwJ+mI2C3nRpnQutvKDhO7KRAMGTBxY5j5UVHXar0k67U9MXSbC3hi
         dtuD2Yo3dUNnQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: ipq9574: enable GPIO based LED
Date:   Thu,  7 Dec 2023 18:57:49 -0800
Message-ID: <170200426908.2871025.1319951665237619510.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231025-ipq9574-led-v2-1-59b2725697ad@quicinc.com>
References: <20231025-ipq9574-led-v2-1-59b2725697ad@quicinc.com>
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


On Wed, 25 Oct 2023 19:01:25 +0530, Kathiravan Thirumoorthy wrote:
> Add support for wlan-2g LED on GPIO64.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: ipq9574: enable GPIO based LED
      commit: 2928212b6ef24d6a4f2af849157ac18546030b97

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
