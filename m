Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7CF8020E3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 05:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbjLCEw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 23:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233168AbjLCEwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 23:52:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07859170B
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 20:51:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40DC5C433CC;
        Sun,  3 Dec 2023 04:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701579114;
        bh=nEojWos07lNJnamlqJbrt8DW5wThbZFynqJl6pMGPRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d2rBOZ7ubLvJwYmh6YQlCz07l2CmRBnbMx00r4RB4GI35C6pYNZGCj0mcRha6/L1l
         iKXpVO8lWX5cYO9Ri2rfvrcMF8Q/wY9F4gekfgO+2vNHGhi7TAS2j/6VJC4atVGXMV
         pqYt30tRS96Fz3FS2XBMH2xO07V9sqlv8eAcBAyIoYHgnm/ZoberzDc1egIlFnPw1r
         gHB+CWE6iA2/3fIGKb6BV4+UkvmpWGnItSeueUiiLYP58R3AdT3MuVCQ4zfRDJF7xb
         9adKVGdGD7M8JAD+HUopTWaigKR7OUQ0MZbY0wdr9Qb5TXjy3RRKfLv5F8H5xDmsY5
         4oDtHMvfAFvGQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Kalle Valo <kvalo@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sdm632-fairphone-fp3: Enable WiFi/Bluetooth
Date:   Sat,  2 Dec 2023 20:54:42 -0800
Message-ID: <170157925817.1717511.6338511271605322593.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231127-fp3-wcnss-v2-1-a5154fae4768@z3ntu.xyz>
References: <20231127-fp3-wcnss-v2-1-a5154fae4768@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 27 Nov 2023 22:55:38 +0100, Luca Weiss wrote:
> Configure and enable the WCNSS which provides WiFi and Bluetooth on this
> device using the WCN3680B chip.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sdm632-fairphone-fp3: Enable WiFi/Bluetooth
      commit: 5b006a82a2bbc0ce18bc6b084fc8d8d9cc110001

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
