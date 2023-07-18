Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D801757856
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjGRJqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjGRJqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:46:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AACA9E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 02:46:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 767D82F4;
        Tue, 18 Jul 2023 02:47:15 -0700 (PDT)
Received: from pluto (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 053623F67D;
        Tue, 18 Jul 2023 02:46:30 -0700 (PDT)
Date:   Tue, 18 Jul 2023 10:46:28 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Sukrut Bellary <sukrut.bellary@linux.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_scmi: Fix signed error return values
 handling
Message-ID: <ZLZfdCBEF9YWtGWa@pluto>
References: <20230718085529.258899-1-sukrut.bellary@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718085529.258899-1-sukrut.bellary@linux.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 01:55:29AM -0700, Sukrut Bellary wrote:
> Handle signed error return values returned by simple_write_to_buffer().
> In case of an error, return the error code.
> 
> Fixes: 3c3d818a9317 ("firmware: arm_scmi: Add core raw transmission support")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Sukrut Bellary <sukrut.bellary@linux.com>
> ---
> This is based on static analysis. Compilation tested.
> ---

Hi Sukrut,

thanks for this.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Tested-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

