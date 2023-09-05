Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0378C792B49
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344483AbjIEQup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353631AbjIEG6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 02:58:00 -0400
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9630BCC7;
        Mon,  4 Sep 2023 23:57:55 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="132125610"
X-IronPort-AV: E=Sophos;i="6.02,228,1688396400"; 
   d="scan'208";a="132125610"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 15:57:53 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
        by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 7431AD424E;
        Tue,  5 Sep 2023 15:57:50 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
        by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id A1DB2BF498;
        Tue,  5 Sep 2023 15:57:49 +0900 (JST)
Received: from [192.168.122.212] (unknown [10.167.226.45])
        by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id C6A6F20074732;
        Tue,  5 Sep 2023 15:57:48 +0900 (JST)
To:     rafael@kernel.org
Cc:     akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ying.huang@intel.com,
        =?UTF-8?B?TGksIFpoaWppYW4v5p2OIOaZuuWdmg==?= 
        <lizhijian@fujitsu.com>
References: <CAJZ5v0jY87yCjmFv2HsJ1ZuDF_9bXW0iM5rqGJdY1DhkEuRdfQ@mail.gmail.com>
Subject: Re: [PATCH] acpi,mm: fix typo sibiling -> sibling
From:   "Li, Zhijian" <lizhijian@fujitsu.com>
Message-ID: <4cb08819-cb9e-9cb7-b5e5-f71f46c35a36@fujitsu.com>
Date:   Tue, 5 Sep 2023 14:57:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jY87yCjmFv2HsJ1ZuDF_9bXW0iM5rqGJdY1DhkEuRdfQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27856.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27856.005
X-TMASE-Result: 10--20.453700-10.000000
X-TMASE-MatchedRID: T3hsd5K8wICPvrMjLFD6eH1zro62qhdCC/ExpXrHizxpLuYUN5mYEtP8
        W0t/rMaUo/aGRMOiEMYYlaKkpnj16XjxgHkp9duCyn0GCvk40qE1A76UULn8VcwZ89GbiUlnXJS
        YlpHrkP2W33kMHBZTlweIFUoppMpZyhywcw6Lc6WdVNZaI2n6//SzAdIVxUnoulGrXrvXpScrVX
        l+/cMArO0B0MT8S0EkX7bicKxRIU1mIVC+RmEW7QTkPo+KkJV0+gtHj7OwNO2OhzOa6g8KrZRMZ
        UCEHkRt
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael,

> On Wed, Aug 2, 2023 at 11:30 AM Li Zhijian <lizhijian@cn.fujitsu.com> wrote:
> > > First found this typo as reviewing memory tier code. Fix it by sed 
> like: > $ sed -i 's/sibiling/sibling/g' $(git grep -l sibiling) > > so 
> the acpi one will be corrected as well. > > Signed-off-by: Li Zhijian 
> <lizhijian@cn.fujitsu.com>
> Please post the ACPI and mm changes as separate patches.

So sorry for the late reply, I haven't noticed my wrong email in this patch until my
colleague tell me it appear in the mm-unstable[1] with this mistake.

Do I need to send another version as you suggested.

[1] https://kernel.googlesource.com/pub/scm/linux/kernel/git/akpm/mm/+/d2f2698ede41980640e884d6f8d9aa2efa4263af

Thanks
Zhijian



> Thanks!

