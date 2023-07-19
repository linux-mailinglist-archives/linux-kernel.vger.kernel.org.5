Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0735B759239
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjGSKAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 06:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjGSKAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:00:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B2DD1FFC
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:00:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 738BC2F4;
        Wed, 19 Jul 2023 03:00:47 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 30FB63F67D;
        Wed, 19 Jul 2023 03:00:03 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>,
        Sukrut Bellary <sukrut.bellary@linux.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_scmi: Fix signed error return values handling
Date:   Wed, 19 Jul 2023 11:00:01 +0100
Message-ID: <168976048963.3011073.12211284328028993513.b4-ty@arm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230718085529.258899-1-sukrut.bellary@linux.com>
References: <20230718085529.258899-1-sukrut.bellary@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2023 01:55:29 -0700, Sukrut Bellary wrote:
> Handle signed error return values returned by simple_write_to_buffer().
> In case of an error, return the error code.
>

Applied to sudeep.holla/linux (for-next/scmi/fixes), thanks!


[1/1] firmware: arm_scmi: Fix signed error return values handling
      https://git.kernel.org/sudeep.holla/c/81b233b8dd72
--
Regards,
Sudeep

