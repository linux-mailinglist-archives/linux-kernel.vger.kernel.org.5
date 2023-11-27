Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398757FA0F5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 14:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbjK0NXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 08:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbjK0NXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 08:23:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DB11B5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 05:23:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619C2C433B9;
        Mon, 27 Nov 2023 13:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701091380;
        bh=34e6n6m+2RJavyVA7BHcIYWwWMAhTNkHTD3FkOlHlcY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=NPsJzX5fAho9QFkhty3D+NJSw5DG6A3+7zlKb2a7IBa2l/SFMvRqh5qdZvrGkhQ1m
         t7hGZke542Vbno3YnwzzFoAq18CQa9mhc/XNytwAdtZXPHcJD4ukLHPS+WDTVFZYov
         BPa0kOBl5JyCqqIq433jmM618zrpvYXnyeeKStFTxImOHZ8csHtoB2C4SwYWp6l/9D
         AKMbLDD0fUUi9eA/cRBlRa6UZCZXQ0VYrmeHqUtMI/lOBxvg8Tby3Ob/UvljD4x1I0
         XxZKcblo0FVceelTtWNVJw4oWsVa+Jn9vb77U8JANM6N/3M1IaLsE7F96AxkL8/LBP
         ujY07xbZ4lzlw==
From:   Vinod Koul <vkoul@kernel.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        kishon@kernel.org, dmitry.baryshkov@linaro.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231117061501.537529-1-quic_rohiagar@quicinc.com>
References: <20231117061501.537529-1-quic_rohiagar@quicinc.com>
Subject: Re: [PATCH v5] phy: qcom-qmp-usb: Add Qualcomm SDX75 USB3 PHY
 support
Message-Id: <170109137700.42627.3042149947525086118.b4-ty@kernel.org>
Date:   Mon, 27 Nov 2023 18:52:57 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 17 Nov 2023 11:45:01 +0530, Rohit Agarwal wrote:
> Add support for USB3 QMP PHY found in SDX75 platform.
> 
> 

Applied, thanks!

[1/1] phy: qcom-qmp-usb: Add Qualcomm SDX75 USB3 PHY support
      commit: 7f6f9e0def00cfaeb1d034fd13dbd84470aeccbd

Best regards,
-- 
~Vinod


