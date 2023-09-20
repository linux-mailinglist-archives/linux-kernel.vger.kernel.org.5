Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFA67A83A9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbjITNmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234626AbjITNmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:42:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C26C8A9;
        Wed, 20 Sep 2023 06:42:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB38E1FB;
        Wed, 20 Sep 2023 06:42:52 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 369C23F67D;
        Wed, 20 Sep 2023 06:42:14 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     cristian.marussi@arm.com, lukasz.luba@arm.com,
        Sibi Sankar <quic_sibis@quicinc.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        quic_rjendra@quicinc.com, srinivas.kandagatla@linaro.org,
        Chandra Sekhar Lingutla <quic_lingutla@quicinc.com>
Subject: Re: [PATCH] firmware: arm_scmi: Fixup perf microwatt support
Date:   Wed, 20 Sep 2023 14:42:05 +0100
Message-ID: <169521729499.2982112.1662024331315358592.b4-ty@arm.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230811204818.30928-1-quic_sibis@quicinc.com>
References: <20230811204818.30928-1-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Aug 2023 02:18:18 +0530, Sibi Sankar wrote:
> The perf power scale value would currently be reported as bogowatts if the
> platform firmware supports microwatt power scale and meets the perf major
> version requirements. Fix this by populating version information in the
> driver private data before the call to protocol attributes is made.
>

Applied to sudeep.holla/linux (for-next/scmi/fixes), thanks!

[1/1] firmware: arm_scmi: Fixup perf microwatt support
      https://git.kernel.org/sudeep.holla/c/c3638b851bc1
--
Regards,
Sudeep

