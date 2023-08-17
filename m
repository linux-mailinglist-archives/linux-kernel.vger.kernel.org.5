Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB3E77FF61
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 22:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355083AbjHQU5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 16:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355075AbjHQU5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 16:57:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9583830F6;
        Thu, 17 Aug 2023 13:57:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3358D61F4A;
        Thu, 17 Aug 2023 20:57:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41FB8C433C7;
        Thu, 17 Aug 2023 20:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692305843;
        bh=Cz0bpZIHuJ97+/eXABSNnd6abp7icCo53irEIi6xom8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=spITFcVVlHEtmVsTgC3Q31Ykp2iku/xtv5XwL1pBcBZOIbV6UX0oi4KQqbLDl11bL
         GFiayMB2cNx8kAXVwgTaO85j3Ipesr1hy0pLVSjc3oxfXy7Y0KznBwx8HToLd808JR
         jTFpzG8LG1703IDEWF3JL1eEqiKrErC93xyMwbOo=
Date:   Thu, 17 Aug 2023 22:57:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ram Kishore Vegesna <ram.vegesna@broadcom.com>
Cc:     Dmitry Bogdanov <d.bogdanov@yadro.com>, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, jejb@linux.ibm.com,
        rdunlap@infradead.org, james.smart@broadcom.com,
        linux-kernel@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] scsi: sli4: Remove the buggy code
Message-ID: <2023081755-virus-showman-f3b2@gregkh>
References: <20230817103751.16350-1-coolrrsh@gmail.com>
 <20230817105252.GA14370@yadro.com>
 <CAF7aS0rrZvZK_bE21Umrr+RAGgQB6-qDdoqSPnKh6f7HcX8Ovw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF7aS0rrZvZK_bE21Umrr+RAGgQB6-qDdoqSPnKh6f7HcX8Ovw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 06:03:32PM +0530, Ram Kishore Vegesna via Linux-kernel-mentees wrote:
> -- 
> This electronic communication and the information and any files transmitted 
> with it, or attached to it, are confidential and are intended solely for 
> the use of the individual or entity to whom it is addressed and may contain 
> information that is confidential, legally privileged, protected by privacy 
> laws, or otherwise restricted from disclosure to anyone else. If you are 
> not the intended recipient or the person responsible for delivering the 
> e-mail to the intended recipient, you are hereby notified that any use, 
> copying, distributing, dissemination, forwarding, printing, or copying of 
> this e-mail is strictly prohibited. If you received this e-mail in error, 
> please return the e-mail to the sender, delete it from your computer, and 
> destroy any printed copy of it.

Now deleted.

(hint, this footer is not compatible with kernel development, please fix
your email system...)
