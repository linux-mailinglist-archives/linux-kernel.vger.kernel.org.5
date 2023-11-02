Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E233D7DF0F1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 12:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376264AbjKBLKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 07:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347307AbjKBLK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 07:10:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18053185
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 04:10:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 909CB2F4;
        Thu,  2 Nov 2023 04:10:58 -0700 (PDT)
Received: from bogus (unknown [10.57.82.56])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E50423F67D;
        Thu,  2 Nov 2023 04:10:14 -0700 (PDT)
Date:   Thu, 2 Nov 2023 11:08:42 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     sean yang <seanyang230@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, cristian.marussi@arm.com
Subject: Re: Fwd: [PATCH] firmware: arm_scmi: Remove inappropriate error log.
Message-ID: <20231102110842.GB1391942@bogus>
References: <20231101081726.1163042-1-xinglong.yang@cixtech.com>
 <CADGqjF+qsrKcNntO7FdcUxJ+L4rC8jcMT94nv8uOOTH-VwG9mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADGqjF+qsrKcNntO7FdcUxJ+L4rC8jcMT94nv8uOOTH-VwG9mw@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 05:55:37PM +0800, sean yang wrote:
> ---------- Forwarded message ---------
> 发件人： xinglong.yang <seanyang230@gmail.com>
> Date: 2023年11月1日周三 16:17
> Subject: [PATCH] firmware: arm_scmi: Remove inappropriate error log.
> To: <xinglong.yang@cixtech.com>, <sudeep.holla@arm.com>,
> <cristian.marussi@arm.com>
> Cc: <linux-arm-kernel@lists.infradead.org>
> 

Same here, please avoid forwarding patches/emails on the list and wait
for couple of days to *resend*(not forward) the email/patch if you
suspect it wasn't delivered.

-- 
Regards,
Sudeep
