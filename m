Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0714E802108
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 05:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbjLCE4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 23:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbjLCE4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 23:56:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211D826B2
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 20:52:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49BBBC4339A;
        Sun,  3 Dec 2023 04:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701579131;
        bh=/BK9sneiywqbw/2AYIt8hfLlFSPiv1QzMH5lU43mbYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S4N6YGMO5flZ/w3EhTGiHktojzUSQqzga1Vgr4bvyBTGI+nxvhT2yRxmxmUPCoWtA
         +F/1Xd1+dk3HEV+U+M5mUT1cLcnA2EQ3nOLTI6LbnclQAYjNGntTagzc74LbxahNLD
         0By4PwFxPBlK0gMKXoqoBuKELdQE5yQxQ2p+VSpdGcSHX6b/N338KPv+O+5PlYwFTx
         ZUuU6eI43kVd9c1MaWKbQKaQ6PwGWIKHigI80Rd4NBUb5otr2/JMVUPCBcqOVHft1N
         7kVQGndBpUYFSdESfiS8NbDMgi7MqxYsO3bIufWbZpXhAvZtmpMqqhi6IXnl3cFgUi
         HTrxi1e+2iAmw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>,
        Douglas Anderson <dianders@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2] dt-bindings: arm: qcom: Fix html link
Date:   Sat,  2 Dec 2023 20:54:56 -0800
Message-ID: <170157925814.1717511.17865242683482227464.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231129030443.2753833-1-swboyd@chromium.org>
References: <20231129030443.2753833-1-swboyd@chromium.org>
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


On Tue, 28 Nov 2023 19:04:41 -0800, Stephen Boyd wrote:
> This link got broken by commit e790a4ce5290 ("arm: docs: Move Arm
> documentation to Documentation/arch/") when the doc moved from arm/ to
> arch/arm/. Fix the link so that it can continue to be followed.
> 
> 

Applied, thanks!

[1/1] dt-bindings: arm: qcom: Fix html link
      commit: 3c3fcac8d3b1b0f242845c3b3c3263bd38b3b92f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
