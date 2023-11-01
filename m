Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2777DE924
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 00:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjKAXxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 19:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjKAXxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 19:53:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E57119
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 16:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698882823; x=1730418823;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8No9qD3NopqdlPoaq0kKHzHKIDnfhkU+1rIhmFx3lKA=;
  b=GJF/iMXS4Ynfugy5WRcXEEBXvSrbP9IiqHg1+4IhBNcr1bKl9sIkCKhd
   vFoCCL0187bXPfGJOB24uTPsjjjispV5/Rn+yEeK+/AvOkxvxC2tBFuLz
   g2qYM0Ia7tCjykyVDChDGMjQ6GBV/5vZ071QQOYaFDmTHc7unT1liHHSC
   YsT82Da/lh8Bm91kHBoIwh5aJqJwGX+lLt+Vd/X1ePl/n4owfndfLWGHj
   GKqMywzzCLtMuRFojHGah4v1H2YDB29I0udskULR6ul4qy0jMdLPQTzDK
   MDmXgyZ7eVaFXIrnPhnGalDn+V8xY4dJgQNAt1ALnUwa7XAAwZpbxwtGx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="385777358"
X-IronPort-AV: E=Sophos;i="6.03,269,1694761200"; 
   d="scan'208";a="385777358"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 16:53:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="884702862"
X-IronPort-AV: E=Sophos;i="6.03,269,1694761200"; 
   d="scan'208";a="884702862"
Received: from mckitto-mobl1.amr.corp.intel.com (HELO [10.209.109.254]) ([10.209.109.254])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 16:53:42 -0700
Message-ID: <4b05bf79-c394-4a63-b6d5-eccbdc708115@linux.intel.com>
Date:   Wed, 1 Nov 2023 16:53:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add Intel TDX entry
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, Kai Huang <kai.huang@intel.com>,
        linux-kernel@vger.kernel.org
References: <20231101233314.2567-1-kirill.shutemov@linux.intel.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20231101233314.2567-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/1/2023 4:33 PM, Kirill A. Shutemov wrote:
> Add myself as Intel TDX maintainer.
> 
> I drove upstreaming most of TDX code so far and I will continue
> working on TDX for foreseeable future.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> ---

Acked-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  MAINTAINERS | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7608b714653f..1cbec6b235f9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23466,6 +23466,18 @@ F:	arch/x86/kernel/dumpstack.c
>  F:	arch/x86/kernel/stacktrace.c
>  F:	arch/x86/kernel/unwind_*.c
>  
> +X86 TRUST DOMAIN EXTENSIONS (TDX)
> +M:	Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> +L:	x86@kernel.org
> +L:	linux-coco@lists.linux.dev
> +S:	Maintained
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/tdx
> +F:	arch/x86/boot/compressed/tdx*
> +F:	arch/x86/coco/tdx/
> +F:	arch/x86/include/asm/shared/tdx.h
> +F:	arch/x86/include/asm/tdx.h
> +F:	arch/x86/virt/vmx/tdx/
> +

Do you want to include drivers/virt/coco/tdx-guest?

>  X86 VDSO
>  M:	Andy Lutomirski <luto@kernel.org>
>  L:	linux-kernel@vger.kernel.org

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
