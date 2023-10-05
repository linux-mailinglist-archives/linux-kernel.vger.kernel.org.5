Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4027BA237
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbjJEPVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbjJEPUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:20:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B0A5276
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:45:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56841C433CA;
        Thu,  5 Oct 2023 14:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696517128;
        bh=ySSB8dqCBr1xpkIgm/fbXbfeKlckkl5zAkPd/HQdx9s=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=rHluXATFhhSPCAqYrNQu1wPH90Ed0nhzvobXLZp85XRKCGxhpjiZQkUA/WGs07z8W
         psOau0ksno6Yq9Ae/mx3foWHQJZG5xWcVtL8wCJTrMQ6LXiOC7daeRysBnF1GK9vQX
         kGrwAE9mRWqyyrGrw1rS+In77P8+Cq9bDXyAnGQHQ5Gq99FWNImT4UOOrFeoZeR5fw
         67TD/owOGgpiSCnBQZE8mblJBs57DYWe1H1zJILLjzA+UzJa+6Jq3TZECf8UqAhpIw
         qVTSTRpbfwn9RhEuLMQcUeA58Pf/LhJ/etW/x3E73r+qBdt6DYArGLjYWzYXyCAX27
         aaLWmA0cSa53g==
From:   Lee Jones <lee@kernel.org>
To:     yilun.xu@intel.com, trix@redhat.com, lee@kernel.org,
        linux-kernel@vger.kernel.org,
        Russ Weight <russell.h.weight@intel.com>
Cc:     matthew.gerlach@linux.intel.com, peter.colberg@intel.com
In-Reply-To: <20230928164738.278635-1-russell.h.weight@intel.com>
References: <20230928164738.278635-1-russell.h.weight@intel.com>
Subject: Re: [PATCH 3/3] mfd: intel-m10-bmc: Change contact for ABI docs
Message-Id: <169651712705.802854.7572206393596117594.b4-ty@kernel.org>
Date:   Thu, 05 Oct 2023 15:45:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2023 09:47:38 -0700, Russ Weight wrote:
> Change ABI documentation contact information from Russ Weight to
> Peter Colberg.
> 
> 

Applied, thanks!

[3/3] mfd: intel-m10-bmc: Change contact for ABI docs
      commit: 89c8e0520d2df61e78d4201b5514e8877de9f1a5

--
Lee Jones [李琼斯]

