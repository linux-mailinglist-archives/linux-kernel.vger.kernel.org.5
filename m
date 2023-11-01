Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E202C7DE182
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 14:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344255AbjKAN1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 09:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343920AbjKAN1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 09:27:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BBBC3F7;
        Wed,  1 Nov 2023 06:27:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C02D2F4;
        Wed,  1 Nov 2023 06:27:52 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B83703F64C;
        Wed,  1 Nov 2023 06:27:07 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>, andersson@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Song Chai <quic_songchai@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        linux-arm-kernel@lists.infradead.org, Leo Yan <leo.yan@linaro.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        coresight@lists.linaro.org
Subject: Re: [PATCH v1] coresight-tpdm: Correct the property name of MSR number
Date:   Wed,  1 Nov 2023 13:26:59 +0000
Message-Id: <169884518439.1280348.11104684783715031934.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <1698128353-31157-1-git-send-email-quic_taozha@quicinc.com>
References: <1698128353-31157-1-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2023 14:19:13 +0800, Tao Zhang wrote:
> Correct the property name of the DSB MSR number that needs to be
> read in TPDM driver. The right property name is
> "qcom,dsb-msrs-num".
> 
> Fixes： 90a7371cb08d ("coresight-tpdm: Add nodes for dsb msr support")
> 
> 
> [...]

Applied, thanks!

[1/1] coresight-tpdm: Correct the property name of MSR number
      https://git.kernel.org/coresight/c/20234c51cca7

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>
