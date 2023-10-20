Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63EA7D12B8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377704AbjJTPa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377691AbjJTPaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:30:24 -0400
X-Greylist: delayed 286 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 20 Oct 2023 08:30:20 PDT
Received: from sjdc-mailout6.udc.trendmicro.com (sjdcvmout03.udc.trendmicro.com [66.180.85.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD981A3;
        Fri, 20 Oct 2023 08:30:20 -0700 (PDT)
Received: from sjdc-mailout6.udc.trendmicro.com (unknown [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 1603FB61FE1;
        Fri, 20 Oct 2023 15:25:34 +0000 (UTC)
Received: from sjdc-mailout6.udc.trendmicro.com (unknown [127.0.0.1])
        by DDEI (Postfix) with ESMTP id F0B8FB61DDB;
        Fri, 20 Oct 2023 15:25:33 +0000 (UTC)
X-TM-AS-ERS: 10.45.168.5-127.5.254.253
X-TM-AS-SMTP: 1.0 U0pEQy1FWENIMDIuZXUudHJlbmRuZXQub3Jn emRpLWRpc2Nsb3N1cmVzQ
        HRyZW5kbWljcm8uY29t
X-DDEI-TLS-USAGE: Unused
Received: from SJDC-EXCH02.eu.trendnet.org (unknown [10.45.168.5])
        by sjdc-mailout6.udc.trendmicro.com (Postfix) with ESMTP;
        Fri, 20 Oct 2023 15:25:33 +0000 (UTC)
Received: from SJDC-EXCH01.eu.trendnet.org (10.45.168.3) by
 SJDC-EXCH02.eu.trendnet.org (10.45.168.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 20 Oct 2023 15:25:31 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by exhybridnabu.trendmicro.com (10.45.168.4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27 via Frontend Transport; Fri, 20 Oct 2023 15:25:31 +0000
Received: from DM5PR0102MB3477.prod.exchangelabs.com (2603:10b6:4:a1::19) by
 SA0PR01MB6426.prod.exchangelabs.com (2603:10b6:806:e8::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.24; Fri, 20 Oct 2023 15:25:27 +0000
Received: from DM5PR0102MB3477.prod.exchangelabs.com
 ([fe80::ed40:6233:b47c:50a5]) by DM5PR0102MB3477.prod.exchangelabs.com
 ([fe80::ed40:6233:b47c:50a5%7]) with mapi id 15.20.6886.034; Fri, 20 Oct 2023
 15:25:27 +0000
From:   "zdi-disclosures@trendmicro.com" <zdi-disclosures@trendmicro.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     "valentina.manea.m@gmail.com" <valentina.manea.m@gmail.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "i@zenithal.me" <i@zenithal.me>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: ZDI-CAN-22273: New Vulnerability Report 
Thread-Topic: ZDI-CAN-22273: New Vulnerability Report 
Thread-Index: AdoDaZfX1Pq+Y8aLRweLJ8giuYn76Q==
Content-Class: 
Date:   Fri, 20 Oct 2023 15:25:27 +0000
Message-ID: <DM5PR0102MB347711AF2F5655852AC60BEB80DBA@DM5PR0102MB3477.prod.exchangelabs.com>
Accept-Language: en-US, es-ES
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_ActionId=0581cfcd-4b24-47bc-9c0b-7595956bc2ab;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_ContentBits=0;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Enabled=true;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Method=Privileged;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Name=Public
 Information - no
 protection;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_SetDate=2023-10-20T15:24:50Z;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_SiteId=3e04753a-ae5b-42d4-a86d-d6f05460f9e4;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR0102MB3477:EE_|SA0PR01MB6426:EE_
x-ms-office365-filtering-correlation-id: 8cf55de6-c71d-4419-c93a-08dbd180c9fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KSzKDQ//8VVcniekploKkYc3X/EzALH521HswfrR2UihVtn6EU4aRt3jpJ6T6evAuFqEezvCJ0xoUXb3RV6tc5NHakTGfcCvaXylIkRFAtFXEzjzcnRja3t6hwAikmmRL5P3DLiFkilzfor3tMYzb2F/KQn1SLMqimwYzeVX9gGGIPMrFyGDp0J20pGcj0uCeyillcCZjxeCupp2cYIxLlDEGbmp0w2+ojNsnTHiEfloFgbjfD0v0CJ9WB4TrIeAY+MpFxDouJOnNZOxFh5ub0WRvFPBxFLk92ZfAQTg4ZDaSSgAjdE0xZqryBnHkK9sjrSxe/rp0UWCHZaejtXtF4mwgukjEw0Alij1SQRNSMkmACAOCBKyTk1IpK9NuDgvdcWe3xdrQhIUuuQq7un4rijj2kSKtyTYi6EY/EETKlBCuR5gYLm4IKp12i/NMIuyEfSFKCgZcJ5G+B6r8Uo8nAqArd+1dFF9LAxfBdwT7MVz31jSKCpch7YDdDgxfb9nP4qCajVEsF6Iy0MwnO9x+L2H3XGif6VKLTEqXlEyMhsFAAtCBbys2pMJVWOaEJ98gSf87cIcjBSYaTUYxzyDhw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3477.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(366004)(376002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(55016003)(71200400001)(2906002)(4743002)(26005)(30864003)(9686003)(6506007)(7696005)(83380400001)(54906003)(4326008)(8936002)(8676002)(66476007)(316002)(5660300002)(38070700009)(52536014)(41300700001)(478600001)(66556008)(966005)(66446008)(66946007)(110136005)(76116006)(64756008)(82960400001)(33656002)(86362001)(38100700002)(99936003)(122000001)(574254001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kK4+jtCS1ebh5bcbIhQRPm4BzJ63K03EOgeFVf6zPUcb5bQ0V49P4SQ+9PHu?=
 =?us-ascii?Q?mcYRyl9p4yeuzDEoXlwA1MkYAPxhgeEDjfqSKh/dEttvkKqJdgBPKFoTIxd4?=
 =?us-ascii?Q?3xFM1dnJ+B+FaEK0q3gpfgRTM5irVsB7wZL9wyUlSznVHy4MTFj0PrCWX7OQ?=
 =?us-ascii?Q?rYoeKQsp0m51SyoF3J4XQwltqCS8kMYprgcGSd/+dJWlNedlluUz4VAS+jAr?=
 =?us-ascii?Q?Gn0ghUcD4CkGRz9GvpP4PooYv14RJaEJMYnttnqsdOS7EQnLtcYisNB9pOOl?=
 =?us-ascii?Q?TeEcA7ONuGxv7Kvsb5uYwe7INkZvHB+J5Q3w8eY5rmcYaz/EgvSXsufWChSY?=
 =?us-ascii?Q?Rv54ZNWwmtHATwmO5dypA7q31oSIUx3dCcX7MXSFJ60W0NWN82fPh+aDGJLo?=
 =?us-ascii?Q?gVduzh4hVicjxDZH+sVCbka6XCqilz8ESYx9yee0YBgZ8eJ2VBmKqD9IAJ0y?=
 =?us-ascii?Q?knancFSRjELyyaODfKSKTNg/9PPqeLTtHjAOHEryS66QB0B8R2zI4plXXsDP?=
 =?us-ascii?Q?PICSwGlrHKdMwIje14wV8p99ympoBqMjJWAXpBZWSq0libO2Yoox7YVJFDWX?=
 =?us-ascii?Q?uedE0H3Y80j9wW1qxc2q1DoRpEkNS7hdq757P1SKqzTQcox/8V6H0ykTmGiB?=
 =?us-ascii?Q?cM5PnBO7EHKfQARGdrsqnIpfp4Sau3MSHyKO5zq7U3e/00kGhkuNbcbn+kfv?=
 =?us-ascii?Q?qHLr/N4D8K5VNku/qeFyCSTlzDB6nOBdgjDZn9pSeC33I02EaZLaQXJwtDcE?=
 =?us-ascii?Q?j2lPCECDFMfc2lweSeC6SBKJPAZbdr9isgTgH077XdbLXCDa3KJAJ2bzY/iQ?=
 =?us-ascii?Q?6ELGMAKx7vm74wvXp6N1awnmd4WDthEvm/qRLrgaze9WIQpXaFnsJTwxfo4b?=
 =?us-ascii?Q?KXFPvpCePSb7tH+CI7K5eFd2cgBxXqMlafeGFWpkZA8FsSnYDo89AIsk3LAk?=
 =?us-ascii?Q?XRlqNtDZ+9rA10HgjGs9xSeuXzihzgTsSXCTdGj26KIlU3uuq7IeSghdGChN?=
 =?us-ascii?Q?nviW7oPcGpgI1v6uTQUrdDSeQExteeKXps6hyVmNx9mP3uPsnkEQqLn7aaZI?=
 =?us-ascii?Q?IXTGr4LnXVRe4nxavnjVjlD5OyNS6fg6aEzeOam+wtdd7gQfxX7UvOTDl/1s?=
 =?us-ascii?Q?DbFBNjqCpIZosWVNHDF3FioUEoDEptt535RgLu/BKs99WAoUgJzXmrUy8SvY?=
 =?us-ascii?Q?httM228VscEo3dBWaaenw6RXpMlvG57O9urVdtDYHM/R907GGsU2oYkEum47?=
 =?us-ascii?Q?58A43Wrstv+zJF6UM2asB9cRc2QrIT7O7tuNx4ES2yPoAtbyZV5PxWUUxXuG?=
 =?us-ascii?Q?ehrTkNbOd/v1fIGfgDrWJq2VIveGLAutY3SPAHLx3kXv/yDEf4ziZ96JeuEw?=
 =?us-ascii?Q?7khmABn11Synl2MIh9WeWwFDyQhHN317OFVaHouDQ6uCbyiKXW4Mx3uzKMhn?=
 =?us-ascii?Q?rwBALScnNCVr2YkhOFPPTj8gcZnsNQPJZ3ESmhXDhEfg5XFYkhNNvyvnzVl8?=
 =?us-ascii?Q?PIGtTkWjoq75MdH9H3jvsIAdc56OzhhJZtE3B1xCqQfcZ8bSRw/5Q1DW8zPM?=
 =?us-ascii?Q?uzKwZCkoZax66zTxCXvG0GtmmQf4c4uW/TsOsGiUwulxAUdYVrlMPyMJHz6U?=
 =?us-ascii?Q?DNBaJwCQ7N+OdQtXRrcK8L3y3R4A61hjfLl91zYxR8iC?=
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgfLcolxrOoDDf1arxMAixygLvCxxs81CN6jJiRu6hBTGKXq5Na9vbhJSYHAQEZmnaxNZY59Qj1I+lXoJhIPxYtJu9i+ypCzB15vDbuu573khW4BRmSLCEb4mmiGGpyhckccAT64M9c/bkMfKyu3EbAYFG+fRjnx8VH/s5dBo+U7Rx0fdxKqUk6EmFx5AiqZUfnAzq0g7g0ekJtqhY4ckI3LlNcuriQesw0cUojD/JlTZWp9y2/Vu6ZRJ8ytugXRNWV2jAHd+lJX3RyUUPlMrnKFsawa5ACk5x9ttKdJImM1wRu2Kd1KEgm5uTwf0MCGKaMPxEun9gL8vwqLX/ygLw==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6+wcvgNgpwhdxlOJGHQDEr9lXUzLq/BoOzWUNasY5E=;
 b=DtfQJEnXoRyFTF63RblF3jKLm/gT32yjRO8l+1A2K3TYzTsJSfoMV42HG2j/OkyGbfMZPlq2TnpeCCi9NPApV3p3p5sKytic6SwBzwj43/5xC+SkJomv2ww9FIZIkblGUZUPWj0ls2V7lPmy3fzJIFQ8p8uPyzDUyqliIOt9I7zqsR8nHGy5Yhwat4OqHoTw/F6SV8pNXopoduSDflIiB3SOMgYI5lsSowCIeyutNGWGegCjhkrhjHMGfHXxrStQfVZFCDhrA42s3YtjSDdE41Tkz3AmTY6jnflfKG4uGXgn1raQXHp/tm/IHyGozVF7i4YZSIb5x4vU1AARpHTiMQ==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=trendmicro.com; dmarc=pass action=none
 header.from=trendmicro.com; dkim=pass header.d=trendmicro.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: DM5PR0102MB3477.prod.exchangelabs.com
x-ms-exchange-crosstenant-network-message-id: 8cf55de6-c71d-4419-c93a-08dbd180c9fa
x-ms-exchange-crosstenant-originalarrivaltime: 20 Oct 2023 15:25:27.7549 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 3e04753a-ae5b-42d4-a86d-d6f05460f9e4
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: 37cSDPYj1//qaG/3+QZLCBJpDmzBj76pjGW0KYIXS964jXPAUDU5aWe5OaF63DK3hSLIlv/v46WjOKNainC6klfcoMW5NJMict1gZQfOOXM1x8cBHJQHpbuycq+tmknE
x-ms-exchange-transport-crosstenantheadersstamped: SA0PR01MB6426
x-originatororg: trendmicro.com
x-tm-as-product-ver: SMEX-14.0.0.3092-9.0.1002-27948.000
x-tm-as-result: No-10--30.610800-5.000000
x-tmase-matchedrid: 2rB+w6GmFBQ2eFTDBkQySqzGfgakLdjavhbU5J9dplIXjbCEtErbdLtS
        UsE9MLDydjJZ7dbAVkmGUgpA+K6TNsc9PPPpWod0EVuC0eNRYvKwFIDW25lVJg3vouJTzOe2n4L
        fqES/avfS4IeXiveCU/bwUE3l2V0wDytg73Zv02ZO5y1KmK5bJRSLgSFq3Tnj31GU/N5W5BD8bd
        qAerXT973SKCxDfa5NxpZlI8ORWMzs7aQkqkpFyvCW/PNRRp/ZajzNTFMlQCPGP20tc10xwBiis
        L6dYlZs/V2AlYP56XsObu0Pfin+eBZBX4eaTpnn194/5X9VfCwCtGYG0znilICyhoFoDQlZ0EF5
        bRA2V8qHlpOxOPXamX237mlWhg4Rv7yb20jx3jiLzZSKyQypzC4f6nv/C6YGjYip7MRWa0A1Qhz
        yZr8Mz8YzFDLBlYAV6W46Iat5aYaCrAvdroZEJqncG1vVsfbQrpw5pBGQgvPKvc08P155zRxuX4
        MKV/muT9nGAb6VEbXyok7JBT7dMdgSEUcT6ol62Sa33ZGXWdaGcIUgBB5+yINbbeWNBnwkvqAJr
        x96r12VF+4fN1wPuZGEac+cnNfpdDl7ZbBYsOhNsVUJg8FOpoiAeZ2rVOJtDRQo0212LVw0yMSO
        7apIUCuQU9Mn6Lv7wOS+pjyGkA/tNBDY/rfuQuE9BBUXDccUK2GKtdiFmTmbxQuIG3ALnrAkiK8
        pxeP7/ylbX2Ykg6YHP0889utuH5GdeCyBZGjX2h1P6TA0pBtSHjB5Y+o5ZNTSDdVx8njuBl9ykc
        ThHJ+5PHr05f6c+uCksQY3XVtckD+aV92Vkv+JDLgwb/1K2WmRqNBHmBveii7lXaIcF/UXvQkGi
        3tjz9h7Wed3h7oLkU6UkIr/V+20QRlrBF3eZfqBZT9BiOuxI7BTSQvvkgJR91vYtQZgIspOojtD
        C96csLZK1RH1Ihs=
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--30.610800-5.000000
x-tmase-version: SMEX-14.0.0.3092-9.0.1002-27948.000
x-tm-snts-smtp: FCF82B171755A952195F3EDB0762210EDEC5109B16A8AC69F54ED09FD906AC132000:7
Content-Type: multipart/mixed;
        boundary="_002_DM5PR0102MB347711AF2F5655852AC60BEB80DBADM5PR0102MB3477_"
MIME-Version: 1.0
X-TM-AS-ERS: 10.45.168.5-127.5.254.253
X-TM-AS-SMTP: 1.0 U0pEQy1FWENIMDIuZXUudHJlbmRuZXQub3Jn emRpLWRpc2Nsb3N1cmVzQ
        HRyZW5kbWljcm8uY29t
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=trendmicro.com;
        s=tmoutbound; t=1697815534;
        bh=QrvC7lfv7JwEpTqZdL1SSG91xYOG/7fACmH8fOB78jY=; l=17441;
        h=From:To:Date;
        b=GLQ4y60RfXKz1C+GUQFWQlzCCIZ2aYnM6PZe/Y8spAdJrl7rM/oCniWQUFGxD7syq
         iayupMCm98e9yVuGlS7gIuIsX9sncSFPNx9rg2WEGv93kHZwqI8gg9ZsxsZ96c92Qk
         TBGNBY1dxY4Dh7b8Vl34NtW6UadobvBLPtk0WFl8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_DM5PR0102MB347711AF2F5655852AC60BEB80DBADM5PR0102MB3477_
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The attachment could not be scanned for viruses because it is a password =
protected file.
ZDI-CAN-22273: Linux Kernel USB/IP VHCI Driver Race Condition Privilege E=
scalation Vulnerability

-- CVSS -----------------------------------------

7.1: AV:P/AC:H/PR:N/UI:N/S:C/C:H/I:H/A:H

-- ABSTRACT -------------------------------------

Trend Micro's Zero Day Initiative has identified a vulnerability affectin=
g the following products:
Linux - Kernel

-- VULNERABILITY DETAILS ------------------------
* Version tested:6.6-rc3
* Installer file:-
* Platform tested:debian bullseye

---

### Analysis

```
race condition bug exists in the usb/ip VHCI driver
it leads to UAF on `struct usb_device`
thread 1                                                thread 2
vhci_device_reset()                             vhci_urb_enqueue()
 usb_put_dev(vdev->udev);
                                                                 usb_put_=
dev(vdev->udev);               // free
                                                                 vdev->ud=
ev =3D usb_get_dev(urb->dev);    // UAF
 vdev->udev =3D NULL;
```

here is the patch in order to trigger the bug more easier
```
diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 37d1fc34e..7242244d7 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -11,7 +11,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
-
+#include <linux/delay.h>
 #include "usbip_common.h"
 #include "vhci.h"

@@ -781,6 +781,7 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, stru=
ct urb *urb, gfp_t mem_flag
                                usbip_dbg_vhci_hc(
                                        "Not yet?:Get_Descriptor to devic=
e 0 (get max pipe size)\n");

+                       mdelay(200);
                        usb_put_dev(vdev->udev);
                        vdev->udev =3D usb_get_dev(urb->dev);
                        goto out;
@@ -1075,6 +1076,7 @@ static void vhci_device_reset(struct usbip_device *=
ud)
        vdev->devid  =3D 0;

        usb_put_dev(vdev->udev);
+       mdelay(200);
        vdev->udev =3D NULL;

        if (ud->tcp_socket) {
```

KASAN report
```
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-use-after-free in kobject_get+0x130/0x140 /root/linux/li=
b/kobject.c:636
Read of size 1 at addr ffff88804960a0e4 by task kworker/1:1/28

CPU: 1 PID: 28 Comm: kworker/1:1 Not tainted 6.6.0-rc3-dirty #4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian=
-1.16.0-5 04/01/2014
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack /root/linux/lib/dump_stack.c:88
 dump_stack_lvl+0xd9/0x1b0 /root/linux/lib/dump_stack.c:106
 print_address_description /root/linux/mm/kasan/report.c:364
 print_report+0xc4/0x620 /root/linux/mm/kasan/report.c:475
 kasan_report+0xda/0x110 /root/linux/mm/kasan/report.c:588
 kobject_get+0x130/0x140 /root/linux/lib/kobject.c:636
 get_device+0x22/0x30 /root/linux/drivers/base/core.c:3720
 usb_get_dev+0x23/0x30 /root/linux/drivers/usb/core/usb.c:765
 vhci_urb_enqueue+0x5d2/0xea0 /root/linux/drivers/usb/usbip/vhci_hcd.c:78=
6
 usb_hcd_submit_urb+0x2c5/0x2100 /root/linux/drivers/usb/core/hcd.c:1535
 usb_submit_urb+0x878/0x1720 /root/linux/drivers/usb/core/urb.c:581
 usb_start_wait_urb+0x103/0x4c0 /root/linux/drivers/usb/core/message.c:59
 usb_internal_control_msg /root/linux/drivers/usb/core/message.c:103
 usb_control_msg+0x327/0x4a0 /root/linux/drivers/usb/core/message.c:154
 get_bMaxPacketSize0.constprop.0+0xa5/0x1c0 /root/linux/drivers/usb/core/=
hub.c:4725
 hub_port_init+0xb14/0x3840 /root/linux/drivers/usb/core/hub.c:4986
 hub_port_connect /root/linux/drivers/usb/core/hub.c:5369
 hub_port_connect_change /root/linux/drivers/usb/core/hub.c:5580
 port_event /root/linux/drivers/usb/core/hub.c:5740
 hub_event+0x2b64/0x4e00 /root/linux/drivers/usb/core/hub.c:5822
 process_one_work+0x884/0x15c0 /root/linux/kernel/workqueue.c:2630
 process_scheduled_works /root/linux/kernel/workqueue.c:2703
 worker_thread+0x8b9/0x1290 /root/linux/kernel/workqueue.c:2784
 kthread+0x33c/0x440 /root/linux/kernel/kthread.c:388
 ret_from_fork+0x45/0x80 /root/linux/arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 /root/linux/arch/x86/entry/entry_64.S:304
 </TASK>

Allocated by task 28:
 kasan_save_stack+0x33/0x50 /root/linux/mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 /root/linux/mm/kasan/common.c:52
 ____kasan_kmalloc /root/linux/mm/kasan/common.c:374
 __kasan_kmalloc+0xa3/0xb0 /root/linux/mm/kasan/common.c:383
 kmalloc /root/linux/./include/linux/slab.h:599
 kzalloc /root/linux/./include/linux/slab.h:720
 usb_alloc_dev+0x55/0xdb0 /root/linux/drivers/usb/core/usb.c:650
 hub_port_connect /root/linux/drivers/usb/core/hub.c:5343
 hub_port_connect_change /root/linux/drivers/usb/core/hub.c:5580
 port_event /root/linux/drivers/usb/core/hub.c:5740
 hub_event+0x2853/0x4e00 /root/linux/drivers/usb/core/hub.c:5822
 process_one_work+0x884/0x15c0 /root/linux/kernel/workqueue.c:2630
 process_scheduled_works /root/linux/kernel/workqueue.c:2703
 worker_thread+0x8b9/0x1290 /root/linux/kernel/workqueue.c:2784
 kthread+0x33c/0x440 /root/linux/kernel/kthread.c:388
 ret_from_fork+0x45/0x80 /root/linux/arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 /root/linux/arch/x86/entry/entry_64.S:304

Freed by task 28:
 kasan_save_stack+0x33/0x50 /root/linux/mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 /root/linux/mm/kasan/common.c:52
 kasan_save_free_info+0x28/0x40 /root/linux/mm/kasan/generic.c:522
 ____kasan_slab_free /root/linux/mm/kasan/common.c:236
 ____kasan_slab_free+0x138/0x190 /root/linux/mm/kasan/common.c:200
 kasan_slab_free /root/linux/./include/linux/kasan.h:164
 __cache_free /root/linux/mm/slab.c:3370
 __do_kmem_cache_free /root/linux/mm/slab.c:3557
 __kmem_cache_free+0xcc/0x2d0 /root/linux/mm/slab.c:3564
 device_release+0xa1/0x240 /root/linux/drivers/base/core.c:2484
 kobject_cleanup /root/linux/lib/kobject.c:682
 kobject_release /root/linux/lib/kobject.c:716
 kref_put /root/linux/./include/linux/kref.h:65
 kobject_put+0x1d0/0x440 /root/linux/lib/kobject.c:733
 put_device+0x1f/0x30 /root/linux/drivers/base/core.c:3732
 usb_put_dev+0x23/0x30 /root/linux/drivers/usb/core/usb.c:780
 vhci_urb_enqueue+0x5ac/0xea0 /root/linux/drivers/usb/usbip/vhci_hcd.c:78=
5
 usb_hcd_submit_urb+0x2c5/0x2100 /root/linux/drivers/usb/core/hcd.c:1535
 usb_submit_urb+0x878/0x1720 /root/linux/drivers/usb/core/urb.c:581
 usb_start_wait_urb+0x103/0x4c0 /root/linux/drivers/usb/core/message.c:59
 usb_internal_control_msg /root/linux/drivers/usb/core/message.c:103
 usb_control_msg+0x327/0x4a0 /root/linux/drivers/usb/core/message.c:154
 get_bMaxPacketSize0.constprop.0+0xa5/0x1c0 /root/linux/drivers/usb/core/=
hub.c:4725
 hub_port_init+0xb14/0x3840 /root/linux/drivers/usb/core/hub.c:4986
 hub_port_connect /root/linux/drivers/usb/core/hub.c:5369
 hub_port_connect_change /root/linux/drivers/usb/core/hub.c:5580
 port_event /root/linux/drivers/usb/core/hub.c:5740
 hub_event+0x2b64/0x4e00 /root/linux/drivers/usb/core/hub.c:5822
 process_one_work+0x884/0x15c0 /root/linux/kernel/workqueue.c:2630
 process_scheduled_works /root/linux/kernel/workqueue.c:2703
 worker_thread+0x8b9/0x1290 /root/linux/kernel/workqueue.c:2784
 kthread+0x33c/0x440 /root/linux/kernel/kthread.c:388
 ret_from_fork+0x45/0x80 /root/linux/arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 /root/linux/arch/x86/entry/entry_64.S:304

The buggy address belongs to the object at ffff88804960a000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 228 bytes inside of
 freed 2048-byte region [ffff88804960a000, ffff88804960a800)

The buggy address belongs to the physical page:
page:ffffea0001258280 refcount:1 mapcount:0 mapping:0000000000000000 inde=
x:0x0 pfn:0x4960a
flags: 0x4fff00000000800(slab|node=3D1|zone=3D1|lastcpupid=3D0x7ff)
page_type: 0x1()
raw: 04fff00000000800 ffff888012c40800 ffffea000101fb10 ffffea00011b6310
raw: 0000000000000000 ffff88804960a000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2420c0=
(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_COMP|__GFP_THISNODE), pid 7649, tgi=
d 7644 (in:imklog), ts 604730580605, free_ts 603625435624
 set_page_owner /root/linux/./include/linux/page_owner.h:31
 post_alloc_hook+0x2cf/0x340 /root/linux/mm/page_alloc.c:1536
 prep_new_page /root/linux/mm/page_alloc.c:1543
 get_page_from_freelist+0xee0/0x2f20 /root/linux/mm/page_alloc.c:3170
 __alloc_pages+0x1d0/0x4a0 /root/linux/mm/page_alloc.c:4426
 __alloc_pages_node /root/linux/./include/linux/gfp.h:237
 kmem_getpages /root/linux/mm/slab.c:1356
 cache_grow_begin+0x99/0x3a0 /root/linux/mm/slab.c:2550
 cache_alloc_refill+0x294/0x3a0 /root/linux/mm/slab.c:2923
 ____cache_alloc /root/linux/mm/slab.c:2999
 ____cache_alloc /root/linux/mm/slab.c:2982
 __do_cache_alloc /root/linux/mm/slab.c:3182
 slab_alloc_node /root/linux/mm/slab.c:3230
 __kmem_cache_alloc_node+0x3c5/0x470 /root/linux/mm/slab.c:3521
 kmalloc_trace+0x25/0xe0 /root/linux/mm/slab_common.c:1114
 kmalloc /root/linux/./include/linux/slab.h:599
 syslog_print+0xf9/0x5d0 /root/linux/kernel/printk/printk.c:1553
 do_syslog+0x2d4/0x580 /root/linux/kernel/printk/printk.c:1732
 kmsg_read+0x93/0xc0 /root/linux/fs/proc/kmsg.c:37
 pde_read /root/linux/fs/proc/inode.c:316
 proc_reg_read+0x123/0x330 /root/linux/fs/proc/inode.c:326
 vfs_read+0x1ce/0x930 /root/linux/fs/read_write.c:468
 ksys_read+0x12f/0x250 /root/linux/fs/read_write.c:613
 do_syscall_x64 /root/linux/arch/x86/entry/common.c:50
 do_syscall_64+0x38/0xb0 /root/linux/arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd /root/linux/arch/x86/entry/entr=
y_64.S:120
page last free stack trace:
 reset_page_owner /root/linux/./include/linux/page_owner.h:24
 free_pages_prepare /root/linux/mm/page_alloc.c:1136
 free_unref_page_prepare+0x476/0xa40 /root/linux/mm/page_alloc.c:2312
 free_unref_page+0x33/0x3b0 /root/linux/mm/page_alloc.c:2405
 slab_destroy /root/linux/mm/slab.c:1608
 slabs_destroy+0x85/0xc0 /root/linux/mm/slab.c:1628
 cache_flusharray /root/linux/mm/slab.c:3341
 ___cache_free+0x2b7/0x420 /root/linux/mm/slab.c:3404
 qlink_free /root/linux/mm/kasan/quarantine.c:166
 qlist_free_all+0x4c/0x1b0 /root/linux/mm/kasan/quarantine.c:185
 kasan_quarantine_reduce+0x18e/0x1d0 /root/linux/mm/kasan/quarantine.c:29=
2
 __kasan_slab_alloc+0x65/0x90 /root/linux/mm/kasan/common.c:305
 kasan_slab_alloc /root/linux/./include/linux/kasan.h:188
 slab_post_alloc_hook /root/linux/mm/slab.h:762
 slab_alloc_node /root/linux/mm/slab.c:3237
 __kmem_cache_alloc_node+0x163/0x470 /root/linux/mm/slab.c:3521
 __do_kmalloc_node /root/linux/mm/slab_common.c:1022
 __kmalloc_node+0x52/0x110 /root/linux/mm/slab_common.c:1030
 kmalloc_node /root/linux/./include/linux/slab.h:619
 __vmalloc_area_node /root/linux/mm/vmalloc.c:3125
 __vmalloc_node_range+0x3e9/0x1540 /root/linux/mm/vmalloc.c:3320
 alloc_thread_stack_node /root/linux/kernel/fork.c:309
 dup_task_struct /root/linux/kernel/fork.c:1118
 copy_process+0x13e3/0x73f0 /root/linux/kernel/fork.c:2327
 kernel_clone+0xfd/0x920 /root/linux/kernel/fork.c:2909
 kernel_thread+0xc0/0x100 /root/linux/kernel/fork.c:2971
 create_kthread /root/linux/kernel/kthread.c:411
 kthreadd+0x4fb/0x7d0 /root/linux/kernel/kthread.c:746
 ret_from_fork+0x45/0x80 /root/linux/arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 /root/linux/arch/x86/entry/entry_64.S:304

Memory state around the buggy address:
 ffff888049609f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88804960a000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88804960a080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                       ^
 ffff88804960a100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88804960a180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
```


-- CREDIT ---------------------------------------
This vulnerability was discovered by:
Lucas Leong (@_wmliang_) of Trend Micro Zero Day Initiative

-- FURTHER DETAILS ------------------------------

Supporting files:


If supporting files were contained with this report they are provided wit=
hin a password protected ZIP file. The password is the ZDI candidate numb=
er in the form: ZDI-CAN-XXXX where XXXX is the ID number.

Please confirm receipt of this report. We expect all vendors to remediate=
 ZDI vulnerabilities within 120 days of the reported date. If you are rea=
dy to release a patch at any point leading up to the deadline, please coo=
rdinate with us so that we may release our advisory detailing the issue. =
If the 120-day deadline is reached and no patch has been made available w=
e will release a limited public advisory with our own mitigations, so tha=
t the public can protect themselves in the absence of a patch. Please kee=
p us updated regarding the status of this issue and feel free to contact =
us at any time:

Zero Day Initiative
zdi-disclosures@trendmicro.com

The PGP key used for all ZDI vendor communications is available from:

  http://www.zerodayinitiative.com/documents/disclosures-pgp-key.asc

-- INFORMATION ABOUT THE ZDI --------------------
Established by TippingPoint and acquired by Trend Micro, the Zero Day Ini=
tiative (ZDI) neither re-sells vulnerability details nor exploit code. In=
stead, upon notifying the affected product vendor, the ZDI provides its T=
rend Micro TippingPoint customers with zero day protection through its in=
trusion prevention technology. Explicit details regarding the specifics o=
f the vulnerability are not exposed to any parties until an official vend=
or patch is publicly available.

Please contact us for further details or refer to:

  http://www.zerodayinitiative.com

-- DISCLOSURE POLICY ----------------------------

Our vulnerability disclosure policy is available online at:

  http://www.zerodayinitiative.com/advisories/disclosure_policy/
TREND MICRO EMAIL NOTICE

The information contained in this email and any attachments is confidenti=
al and may be subject to copyright or other intellectual property protect=
ion. If you are not the intended recipient, you are not authorized to use=
 or disclose this information, and we request that you notify us by reply=
 mail or telephone and delete the original message from your mail system.

For details about what personal information we collect and why, please se=
e our Privacy Notice on our website at: Read privacy policy<http://www.tr=
endmicro.com/privacy>

--_002_DM5PR0102MB347711AF2F5655852AC60BEB80DBADM5PR0102MB3477_
Content-Type: application/x-zip-compressed; name="ZDI-CAN-22273.zip"
Content-Description: ZDI-CAN-22273.zip
Content-Disposition: attachment; filename="ZDI-CAN-22273.zip"; size=1116;
	creation-date="Fri, 20 Oct 2023 15:24:25 GMT";
	modification-date="Fri, 20 Oct 2023 15:25:27 GMT"
Content-Transfer-Encoding: base64

UEsDBBQACQAIAJo2PFdkeDj3qAMAAN4IAAAHABwAcmVwcm8uY1VUCQADQ7IUZUSyFGV1eAsAAQT1
AQAABBQAAABwKbFZA9pKfu3cbdfS/dOVMJz2yTthi0XdOC23qR0LCxC4fYyElqlO/YjV59/V2sKZ
/1YyU5TjlJv8hXYefSkq/3CMDellacIs8/SktayQ3xSvORjd7Vzy6o+pYGnjkInb9rzTHOG42MaD
/5AHRCieYGFcEtim79fTcO+Ses9cNHax3/BGBlM2O6CL2H2OA15vAnJ0JrDqRYLz9QgiyYLOxeaK
O3T69CPDs3XZxpRWDaO/pu9CIVCy9XXoRQO0aNvS+wUPffGI3hQPuSXe/+H/3Z7LD3OPBAOJ0/kZ
wp8ZwzFpvt0WIGVSziD5snmXfiS1qpUcDRTkoZr4G+7awGnstBLamoPjAKiPSYAqeBJ3k/mwfFy5
u/6eWpldOV/FVOr5dlglF/vJw0x8VhN4tKRaETeNd2MFILhv/JqZ8sijdSl9YzmKQ0zHEuf5JQ70
Wy3gAFaJwCTi85KCkGrdcFKKTHczAOZ9YuqLDGrXtEASeBYeyaWWz8ZMMKEpndYrdMeKtoVusM56
wI+9zd2+HPl5PhyiCIAT1AjDVsWQJmNtaVg/usE7yF4OpsfaEOeGu/j1MopYYRyuPzPpF/FLUgLH
E9RictcgG++f7ae89zXN5ec0wD7bolZUs8VINtdkIg6s7gVHMb0sIYEGo9m3IJtoGCQmGXvFheSU
wieR9VjvbLRE10NpTAKADo5Kfdb4hN006lpqNvnEVPDs0+H68rAzoCu2wZ2Sns/kbEJuDC5IHhVm
nrrFShCUm+cJVuXzfardygDkeYyFpRLgaP0iaCHPcI/NF8dCuaSnesGW8IA5io9//W94T/5DyVk6
7qcscpWQ7Yg6X+bXujJZ687VtlDJk1iEGXT36mejLKlE8ImKiYTj5K2WsS17MWm3G4iyFb1pEL5j
VZyQLVjgRbrKQ2ibOWA84JQDEH8ZUgxJsRSOng8rZif4iFteiWFMByrC2KBkJK2r+ZSKkHTg1JE8
UJM8D9quJI5T01PXtjc7ly65/nrdHzECl4zJWFghFs+nfoHKtRPntQAmd0P4MnEevzPnBOdsgsNP
2y1MJ8QO/7FjL5HfcAziEkfez5DITxkwddux3nJYUGAxf2vmaws8dGPAq0eUxFM4f3Ap/VbL0ty4
P0aIdpw2Ej/04tCmI874R0JPO19x4FRsznNr28XMYfb9sBcBhEhkbx5m+vubQ8R1Aeoj9Dg6Uqgw
jVYlN+wexDCzknbYAyAw5USlT3kLQ0q+0XCOW93Zh4lQSwcIZHg496gDAADeCAAAUEsBAh4DFAAJ
AAgAmjY8V2R4OPeoAwAA3ggAAAcAGAAAAAAAAQAAAKSBAAAAAHJlcHJvLmNVVAUAA0OyFGV1eAsA
AQT1AQAABBQAAABQSwUGAAAAAAEAAQBNAAAA+QMAAAAA

--_002_DM5PR0102MB347711AF2F5655852AC60BEB80DBADM5PR0102MB3477_--

