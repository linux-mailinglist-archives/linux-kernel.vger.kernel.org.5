Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613707A811D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236290AbjITMml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236270AbjITMmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:42:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D74B8F;
        Wed, 20 Sep 2023 05:42:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53223C433C7;
        Wed, 20 Sep 2023 12:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695213753;
        bh=k4Z1wmvH94m6kCfsDSeNjGlbtOzMt7p03Dmb2xg5PR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JnHeeu07A6HpB7Vk5MqcOfUcMHuTV4fuYVM3MGqP6DK5ScKdsmbzIcTsI2oIRH26k
         RDCnDlnBMXj3LjVLyGWY+NEARswOcRcaa+EGW0+i5z1BXvsZBxSTevcOG4p0kC7ijt
         HORu8Jd+OovtkSzI+9tvsazQnvPTFoKK7ZALREkEJjJLNKpThaUSYEdJXgjNEDMZa2
         bj4kId21uT9ORVkztYlf/PE0+VZK+M7ajZMBP3XfB0krd9U4k+Zgp+PqdKQDVTXhxP
         imugeLbMv+PU5jixT5JvYnFfZIJQe/3CUScI8aS8MEcSrn9nEvm4SJwSw0EYPXmrhf
         v6+5EBp5uuVEQ==
Date:   Wed, 20 Sep 2023 05:46:40 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Tengfei Fan <quic_tengfan@quicinc.com>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, djakov@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_tsoni@quicinc.com,
        quic_shashim@quicinc.com, quic_kaushalk@quicinc.com,
        quic_tdas@quicinc.com, quic_tingweiz@quicinc.com,
        quic_aiquny@quicinc.com, kernel@quicinc.com
Subject: Re: [PATCH v4 2/2] pinctrl: qcom: Add SM4450 pinctrl driver
Message-ID: <yyabjpexovdshufxeoi6ezu4gpmy5et4pql2y2mlfjbpzoo7jh@scjasfts6bvl>
References: <20230920082102.5744-1-quic_tengfan@quicinc.com>
 <20230920082102.5744-3-quic_tengfan@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920082102.5744-3-quic_tengfan@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 04:21:02PM +0800, Tengfei Fan wrote:
> Add pinctrl driver for TLMM block found in SM4450 SoC.
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn
