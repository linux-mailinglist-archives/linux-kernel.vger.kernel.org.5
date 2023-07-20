Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E1175AEA7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 14:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjGTMm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 08:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjGTMmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 08:42:54 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82CA2135
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 05:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689856973; x=1721392973;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JaJ/lkSSzUjKz6n6+OtO6yZ6zwybCck47wRM8qdASR0=;
  b=S8WhkuoCjSs5pjYBV9ify5G8xIlFeRvT5A7oL+PIY9n9B6JEaJA5ZsQU
   XMyXUNcLnNbMLMqmwFvho7zLRSse+CE1N54nkjXZRXr4pSMwYb3EL2Pfi
   bR9AiPPqouUhr3VjVxW68x+tUni73SZOcT1Ay2jWZ9qmuEqrzYaLhQs3m
   H3QBvCbmgUHim/J2wPeqk8EtZfSpcOKvdqnAUkheFlO+mRBfzEpTPUfwD
   5y+MO39ZRNi1QUuLcOhwLTcoaL2AYnnQnnr2zVgwSDKO15XfSHn9pIzvE
   I/xxjeTS3sGv7UvdgQJeEfvSjpV4GsijUUk1prMp8CCGxWnJ4QzS4l/to
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="397594575"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="397594575"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 05:42:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="701605663"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="701605663"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.191.109]) ([10.252.191.109])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 05:42:47 -0700
Message-ID: <376985dd-a8b9-b86a-3c12-4633dd4505d7@linux.intel.com>
Date:   Thu, 20 Jul 2023 20:42:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     baolu.lu@linux.intel.com, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com
Subject: Re: [PATCH 04/11] MAINTAINERS: Add myself for RISC-V IOMMU driver
Content-Language: en-US
To:     Tomasz Jeznach <tjeznach@rivosinc.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
References: <cover.1689792825.git.tjeznach@rivosinc.com>
 <e1578b96b9c75433d8c49b6a173ff47a64675c2b.1689792825.git.tjeznach@rivosinc.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <e1578b96b9c75433d8c49b6a173ff47a64675c2b.1689792825.git.tjeznach@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/20 3:33, Tomasz Jeznach wrote:
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> ---
>   MAINTAINERS | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aee340630eca..d28b1b99f4c6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18270,6 +18270,13 @@ F:	arch/riscv/
>   N:	riscv
>   K:	riscv
>   
> +RISC-V IOMMU
> +M:	Tomasz Jeznach <tjeznach@rivosinc.com>
> +L:	linux-riscv@lists.infradead.org

Please add the iommu subsystem mailing list.

iommu@lists.linux.dev

It's the right place to discuss iommu drivers.

> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> +F:	drivers/iommu/riscv/
> +
>   RISC-V MICROCHIP FPGA SUPPORT
>   M:	Conor Dooley <conor.dooley@microchip.com>
>   M:	Daire McNamara <daire.mcnamara@microchip.com>

Best regards,
baolu
