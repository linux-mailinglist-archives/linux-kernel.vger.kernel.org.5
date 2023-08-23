Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364FA785778
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbjHWMFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235002AbjHWMEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:04:45 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5747719A1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 05:04:21 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RW4d62bWBz4x3H;
        Wed, 23 Aug 2023 22:04:10 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linuxppc-dev@lists.ozlabs.org, Michal Suchanek <msuchanek@suse.de>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Alex Williamson <alex.williamson@redhat.com>,
        Timothy Pearson <tpearson@raptorengineering.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>, Li Chen <lchen@ambarella.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Gaurav Batra <gbatra@linux.vnet.ibm.com>,
        Brian King <brking@linux.vnet.ibm.com>,
        Deming Wang <wangdeming@inspur.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20230817162411.429-1-msuchanek@suse.de>
References: <20230817162411.429-1-msuchanek@suse.de>
Subject: Re: [PATCH] powerpc: Move DMA64_PROPNAME define to a header
Message-Id: <169279175575.797584.229615824024413440.b4-ty@ellerman.id.au>
Date:   Wed, 23 Aug 2023 21:55:55 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2023 18:24:08 +0200, Michal Suchanek wrote:
> Avoid redefining the same value in multiple source.
> 
> 

Applied to powerpc/next.

[1/1] powerpc: Move DMA64_PROPNAME define to a header
      https://git.kernel.org/powerpc/c/89c9ce1c99df553029fc4503506ff5a1793f3eaf

cheers
