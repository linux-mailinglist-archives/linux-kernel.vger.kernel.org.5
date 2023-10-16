Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909747CB259
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 20:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbjJPSWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 14:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbjJPSWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 14:22:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11876AC;
        Mon, 16 Oct 2023 11:22:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9A4C433CC;
        Mon, 16 Oct 2023 18:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697480528;
        bh=exthi0CNeGhJZAzUytlzkiBQzqs+H7o+txhy02NswR4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=rZCSKSLxd6FMwLmL7fkW0cppT0eyC2rww3BMNSNg9uv20qnQHnfHYk2HxDhMVOZgo
         RiVEg/EuKfdGlUSZa80vmrCM+l6kVF8uxxSvH5FAe+LfrXZzAZhayr9QeiZUXCxXg0
         QPGLgLphqFGvtP4ptXm2erlQmK438lvpTkBh5qCOLQ7VzXZ03GBHORGCuI+BN+ZjU+
         06wrs40OsGjU2VhnulMVo0apzgOzHuyB8GMsfvU+/3P/WluNw8UGBSdGqVrqGVnD8d
         6US1kProb8LRq2bMEZjUiHjNDSzYMvYP3TQytKWxPh0qQmTYh5EcAsTW/aOlwWLa2c
         5E+o5+VplMbDg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, quic_srichara@quicinc.com,
        quic_varada@quicinc.com, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Nitheesh Sekar <quic_nsekar@quicinc.com>
Subject: Re: (subset) [PATCH V4 0/4] Enable IPQ5018 USB2 support
Date:   Mon, 16 Oct 2023 11:25:50 -0700
Message-ID: <169748074955.1245023.12861217493042461028.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230904063635.24975-1-quic_nsekar@quicinc.com>
References: <20230904063635.24975-1-quic_nsekar@quicinc.com>
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


On Mon, 04 Sep 2023 12:06:31 +0530, Nitheesh Sekar wrote:
> This patch series adds the relevant phy and controller
> DT configurations for enabling USB2 host mode support
> on IPQ5018.
> 
> Tested with a USB Mass storage device.
> 
> Depends on:
> Link: https://lore.kernel.org/linux-arm-msm/20230831030503.17100-1-quic_nsekar@quicinc.com/
> 
> [...]

Applied, thanks!

[3/4] arm64: dts: qcom: ipq5018: Add USB related nodes
      commit: e7166f2774aafefd29ff26ffbbb7f6d40ac8ea1c
[4/4] arm64: dts: qcom: ipq5018: Enable USB
      commit: 80a438775aa398751229bcaed15459f3acdb645f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
