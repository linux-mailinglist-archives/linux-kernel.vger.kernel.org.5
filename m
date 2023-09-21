Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70E07AA049
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjIUUfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjIUUel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:34:41 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFBB89208;
        Thu, 21 Sep 2023 10:39:36 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RrqlK455Tz4xNq;
        Thu, 21 Sep 2023 19:26:05 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     atrajeev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        disgoel@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        Krishan Gopal Sarawast <krishang@linux.vnet.ibm.com>
In-Reply-To: <20230825055601.360083-1-kjain@linux.ibm.com>
References: <20230825055601.360083-1-kjain@linux.ibm.com>
Subject: Re: [PATCH] powerpc/perf/hv-24x7: Update domain value check
Message-Id: <169528828843.872767.14831793424287961680.b4-ty@ellerman.id.au>
Date:   Thu, 21 Sep 2023 19:24:48 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Aug 2023 11:26:01 +0530, Kajol Jain wrote:
> Valid domain value is in range 1 to HV_PERF_DOMAIN_MAX.
> Current code has check for domain value greater than or
> equal to HV_PERF_DOMAIN_MAX. But the check for domain value 0
> is missing.
> Fix this issue by adding check for domain value 0.
> 
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/perf/hv-24x7: Update domain value check
      https://git.kernel.org/powerpc/c/4ff3ba4db5943cac1045e3e4a3c0463ea10f6930

cheers
