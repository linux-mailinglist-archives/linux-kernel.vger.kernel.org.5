Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4158777B028
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 05:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbjHNDZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 23:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbjHNDZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 23:25:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931DAE6D;
        Sun, 13 Aug 2023 20:25:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 319DE62E4C;
        Mon, 14 Aug 2023 03:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08F9C433D9;
        Mon, 14 Aug 2023 03:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691983515;
        bh=kztWJKnxYBYa6fbzC77jUGoshmb3cpWZLZSwgIn9VsU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Kmz641lb54Reg3ciKkEL6JHwMkrasDcRSHDIAPef94JodKKoPQrUd4KTkdILndteb
         x7cLcAekSrDV3iAfecBDNSpm+r+invoTWKm4prhEympBYumGW42RnUfG1AcgwSpBvy
         N0BIyHG4Yp/agMnfcLwiB7xhqh9/Q4/ATOsC0mjpkq148pmwUkWWYQsJ0OljCKrmze
         zpEVrx9jn5jPIk8e1elFreAmd93CRqYdqVgd3nAnsVFhl8a1Mg/uikay2I6JvM1jpa
         uMFtRqomtYALbICdKlhruYnEK0H6kPY8ps4dO8qOmwzn+R2ENTxekNqBQy+OK5gSL0
         n0MBAJ/99ymPQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sridharan S N <quic_sridsn@quicinc.com>
Subject: Re: (subset) [PATCH V4 0/2] Add support for GPIO based leds and buttons on IPQ5332/9574 devices
Date:   Sun, 13 Aug 2023 20:27:44 -0700
Message-ID: <169198364302.2443702.2232287499766217358.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230616083238.20690-1-quic_sridsn@quicinc.com>
References: <20230616083238.20690-1-quic_sridsn@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 16 Jun 2023 14:02:36 +0530, Sridharan S N wrote:
> Add support for wlan-2g led and wps button available on IPQ5332 and
> IPQ9574
> 
> Changes since V1:
> 	- Updated patch series title. Mentioned platform in series
> 	  title
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: ipq5332: enable GPIO based LEDs and Buttons
      commit: 0354e2d4d203bcffb61d671265f9f0bc52b244ff

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
