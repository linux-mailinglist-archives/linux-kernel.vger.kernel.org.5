Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC41B7C0430
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 21:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343919AbjJJTLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 15:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343803AbjJJTLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 15:11:39 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B35DD6;
        Tue, 10 Oct 2023 12:11:36 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id F3ECD46A;
        Tue, 10 Oct 2023 19:11:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net F3ECD46A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1696965096; bh=HUp9N6L6qrdq6mOmkFKiLj5UJh/ZZPu2Xgqi+cTNim0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=MvwOV8UuX2K3hFaHr+iz6rvQ0Sl6r8C/kFFqfM4ve5NmVjtK4UxJWN1PbR8daX3fG
         vjGblI3z+fFLED59DnMQUjLTjZmHJD1bBvZl1VHaJ6kSfIwI6QqRK2AcSMj27zCOO2
         CQAryZS7o/UeOfEoT8v2XumeDvcGTzhFp6eTHYt0n8lARH0X1m3LKCpMxgnIX9veWl
         eiKYaEDWiEaApo99pmESZY+Z4G2b/ZOrBNdcm/hm8vaygT53tmbS3B6NPH1Yy6Al7h
         1TRGXFE7LUDCruFUsAi16qTE6rDxyvqm1CCVUOhgarQUPGTRmi3SSlrYXKNbvslkEv
         AgoaN8Q6BAhjQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [resend, PATCH v1 1/1] PCI: Update the devres documentation
 regarding to pcim_*()
In-Reply-To: <20231006150634.3444251-1-andriy.shevchenko@linux.intel.com>
References: <20231006150634.3444251-1-andriy.shevchenko@linux.intel.com>
Date:   Tue, 10 Oct 2023 13:11:35 -0600
Message-ID: <871qe270ns.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> There were many changes to PCI core in scope of managed resources APIs.
> Update documentation to list the current state of affairs.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  Documentation/driver-api/driver-model/devres.rst | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)

Applied, thanks.

jon
