Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CB780E7EB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346079AbjLLJk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjLLJkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:40:24 -0500
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5D8107;
        Tue, 12 Dec 2023 01:40:25 -0800 (PST)
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
        by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 076B145FA0;
        Tue, 12 Dec 2023 10:40:24 +0100 (CET)
Message-ID: <857901f7-0315-4e5b-9646-ce328e020d45@proxmox.com>
Date:   Tue, 12 Dec 2023 10:40:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SCSI hotplug issues with UEFI VM with guest kernel >= 6.5
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Igor Mammedov <imammedo@redhat.com>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, lenb@kernel.org, rafael@kernel.org,
        Thomas Lamprecht <t.lamprecht@proxmox.com>
References: <20231211161836.GA914318@bhelgaas>
From:   Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20231211161836.GA914318@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 11.12.23 um 17:18 schrieb Bjorn Helgaas:
> 
> Thanks, I opened https://bugzilla.kernel.org/show_bug.cgi?id=218255
> and attached this dmesg log there so this doesn't get lost or expired
> from pastebin.com.
> 

Thank you!

> IIUC this is a log from when it fails.  Can you attach the
> corresponding log when it works correctly?
> 

Yes, it is. I attached the dmesg log for both, a run with the reverts
and a run without the reverts where the issue did not trigger by chance.

Best Regards,
Fiona

